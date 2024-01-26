from flask import Flask, request
from collections import namedtuple
import chatbot
import pandas as pd
import numpy as np

app = Flask(__name__)


@app.route('/')
def index():
    return '<h1>Home Page</h1>'


@app.route('/api')
def api():
    user_input = request.args.get('input')
    response = generate_response(user_input)

    json = {
        'input': user_input,
        'response': response,
    }

    return json



def generate_response(inp: str) -> str:
    
    if inp.lower()=="quit" or inp.lower()=="bye":
      return ""

    results=chatbot.model.predict([chatbot.bag_of_words(inp,chatbot.words)])
    results_index=np.argmax(results)
    tag=chatbot.labels[results_index]

    for tg in chatbot.data["intents"]:
      if tg["tag"]==tag:
        response=tg['responses']

    corpus_text = chatbot.listToString(response)
    return chatbot.answer(corpus_text,inp)


if __name__ == '__main__':
    app.run()