import io
import base64
import numpy as np
import timm
from flask_cors import CORS
from flask import Flask, request, jsonify
from torchvision import transforms
from PIL import Image
import torch
import cv2

app = Flask(__name__)
CORS(app)
# Load the pre-trained PyTorch model
model_path = "/Users/anushka/Documents/temp/citizen/assets/depth_estimator.pth"
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = torch.load(model_path, map_location=device)
model_type = "DPT_Large"
midas = torch.hub.load("intel-isl/MiDaS", model_type)
midas.eval()

def combine_rgb_depth(base64_image):
    # Decode base64 string to bytes
    image_bytes = base64.b64decode(base64_image)
    image_pil = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    img = cv2.cvtColor(np.array(image_pil), cv2.COLOR_RGB2BGR)  # Convert PIL image to OpenCV format
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)  # Convert image to RGB

    with torch.no_grad():
        prediction = midas(img)

        prediction = torch.nn.functional.interpolate(
            prediction.unsqueeze(1),
            size=img.shape[:2],
            mode="bicubic",
            align_corners=False,
        ).squeeze()
    # Depth map
    output = prediction.cpu().numpy()

    # Preprocess RGB image
    rgb_transform = transforms.Compose([
        transforms.Resize((384, 384)),  # Adjust the size to match the depth map size
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
    ])
    rgb_image_tensor = rgb_transform(image_pil).unsqueeze(0)

    # Convert depth map to tensor
    depth_map_pil = transforms.ToPILImage()(torch.from_numpy(output[0]).unsqueeze(0))
    depth_transform = transforms.Compose([
        transforms.Resize((384, 384)),  # Adjust the size as needed
        transforms.ToTensor(),
    ])
    depth_map_tensor = depth_transform(depth_map_pil).unsqueeze(0)

    # Combine RGB image and depth map
    combined_features = torch.cat((rgb_image_tensor, depth_map_tensor), dim=1)
    return combined_features

@app.route('/predict', methods=['POST'])
def predict():
    predicted_class_label = 'screen'
    if 'image' not in request.files:
        return jsonify({'error': 'No image part'})
    
    image = request.files['image']
    if image.filename == '':
        return jsonify({'error': 'No selected image'})

    if image:
        # Read base64 image and preprocess
        base64_image = image.read()
        input_tensor = combine_rgb_depth(base64_image)
    
        model.eval()
        with torch.no_grad():
            outputs = model(input_tensor)
            probabilities = torch.softmax(outputs, dim=1)
            predicted_class = torch.argmax(probabilities, dim=1).item()
            
        class_labels = ['original', 'screen']
        predicted_class_label = class_labels[predicted_class]
                
    return jsonify({'category': predicted_class_label})

if __name__ == '__main__':
    app.run(debug=True, port=8000)
