import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'complaint_confirm.dart';
import 'package:tflite/tflite.dart';

class TakeComplain extends StatefulWidget {
  final String probType;
  final int index;
  const TakeComplain({super.key, required this.probType, required this.index});

  @override
  State<TakeComplain> createState() => _TakeComplainState();
}

class _TakeComplainState extends State<TakeComplain> {
  File? _image; // Variable to store the taken image
  List _predictions = [];
  String status = "Not Verified";

  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
  }

  detectimage(File image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 5,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _predictions = prediction!;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/classify.tflite', labels: 'assets/labels.txt');
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Store the taken image
      });
    }

    detectimage(_image!);
  }

  Future<void> _openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path); // Store the taken image
      });
    }

    detectimage(_image!);
  }

  List<List<String>> problems = [
    // Electrical
    [
      "Frequent Power Outages",
      "Streetlight Not Working",
      "Faulty Wiring",
      "Power Pole Damage",
      "Others"
    ],

    // Sanitation
    [
      "Garbage Dumping in Public Places",
      "Clogged Sewer Drains",
      "Overflowing Trash Bins",
      "Open Defecation Spots",
      "Others"
    ],

    // Road
    [
      "Potholes on Roads",
      "Damaged Road Signs",
      "Road Flooding During Rain",
      "Missing Speed Bumps",
      "Others"
    ],

    // Stray Animals
    [
      "Stray Dog Pack Nuisance",
      "Stray Cattle on Streets",
      "Injured Stray Animals",
      "Wild Animal Sightings",
      "Others"
    ],

    // Water
    [
      "Low Water Pressure",
      "Water Contamination",
      "Leaking Water Pipes",
      "No Access to Clean Water",
      "Others"
    ],

    // Security
    [
      "Street Crime Incidents",
      "Unlit and Unsafe Areas",
      "Suspicious Activity Reporting",
      "Vandalism and Graffiti",
      "Others"
    ],

    // Others
    [
      "Noise Pollution Complaints",
      "Unattended Abandoned Vehicles",
      "Public Health Hazards",
      "Miscellaneous Concerns",
      "Others"
    ],
  ];

  String probDesc = "";
  int isUrgent = 0;

  int selectedRadio = -1;
  // @override
  // void initState() {
  //   super.initState();
  //   selectedRadio = -1; // -1 represents that no radio button is selected initially
  // }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise Complaint'),
        backgroundColor: const Color(0xFF21222D),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: SingleChildScrollView(
            child: Container(
              color: const Color(0xF9F9F9FF),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.probType,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text(
                              "CHANGE",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 22, 61, 202),
                                  fontSize: 20.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Tell us your problem?",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "You can select one or more options",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          Column(
                            children: problems[widget.index]
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              String item = entry.value;
                              return ListTile(
                                title: Text(item),
                                leading: Radio(
                                  value: index,
                                  groupValue: selectedRadio,
                                  onChanged: (val) {
                                    setSelectedRadio(val!);
                                  },
                                  activeColor: Colors.blueGrey,
                                ),
                                // onTap: () {
                                //   setSelectedRadio(index);
                                // },
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Add Details",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Details you think are important for us to know",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                              hintText:
                                  'Eg. There are a lot of power cuts in my area',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                probDesc = value;
                              });
                            },
                            maxLines:
                                null, // Allow the text to wrap to the next line
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text(
                            "Add Photos",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Photos help us understand the gravity of your problems and allocate the best resources for resolution",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _openCamera(); // Open the camera to take a picture
                              print(_predictions[0]['label']
                                  .toString()
                                  .substring(2));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                height: 70.0,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Icon(
                                  Icons.photo_library,
                                  size: 32.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          if (_image != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 150.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Image.file(
                                        _image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    if (_predictions.isNotEmpty &&
                                        (_predictions[0]['label'][0]
                                                .toString() ==
                                            widget.index.toString()))
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.check_rounded,
                                            color: Color.fromARGB(
                                                255, 40, 117, 42),
                                            size: 30,
                                          ),
                                          Text(
                                            // _predictions[0]['label']
                                            //     .toString()
                                            //     .substring(2),
                                            "Verified",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 40, 117, 42),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if (_predictions.isNotEmpty &&
                                        (_predictions[0]['label'][0]
                                                .toString() !=
                                            widget.index.toString()))
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.close_rounded,
                                            color: Color.fromARGB(
                                                255, 173, 24, 44),
                                            size: 30,
                                          ),
                                          Text(
                                            // _predictions[0]['label']
                                            //     .toString()
                                            //     .substring(2),
                                            "Not Verified",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 173, 24, 44),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: isUrgent,
                                onChanged: (value) {
                                  setState(() {
                                    isUrgent = value!;
                                  });
                                },
                                activeColor: Colors.blueGrey,
                              ),
                              const Text(
                                "Is the complaint urgent?",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(
                            color: Color.fromARGB(255, 114, 113, 113),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ComplaintConfirmation(),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: const Color(0xFF21222D), // Button color
                              onPrimary: Colors.white, // Text color
                              fixedSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0), // Adjust the radius as needed
                              ),
                            ),
                            child: const Text(
                              "SUBMIT",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
