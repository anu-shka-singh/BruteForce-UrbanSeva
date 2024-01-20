import pandas as pd
import numpy as np

import tensorflow as tf
import json
import pickle
import random
import tflearn
import string


import nltk
from nltk.stem.lancaster import LancasterStemmer
stemmer =  LancasterStemmer()
from tensorflow.python.framework import ops

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

with open ("lib\intent.json") as file:
  data=json.load(file)
try:
  with open("data.pickle","rb") as f:
    words,labels,training,output=pickle.load(f)
except:
  words=[]
  labels=[]
  docs_x=[]
  docs_y=[]

  for intent in data["intents"]:
    for pattern in intent["patterns"]:
      wrds=nltk.word_tokenize(pattern)
      words.extend(wrds)
      docs_x.append(wrds)
      docs_y.append(intent["tag"])

    if intent["tag"] not in labels:
      labels.append(intent["tag"])

  words=[stemmer.stem(w.lower()) for w in words if w not in "?"]
  words=sorted(list(set(words)))
  labels=sorted(labels)
  training=[]
  output=[]
  out_empty=[0 for _ in range(len(labels))]

  for x,doc in enumerate(docs_x):
    bag=[]

    wrds=[stemmer.stem(w.lower()) for w in doc]
    for w in words:
      if w in wrds:
        bag.append(1)
      else:
        bag.append(0)

    output_row=out_empty[:]
    output_row[labels.index(docs_y[x])]=1

    training.append(bag)
    output.append(output_row)

  training=np.array(training)
  output=np.array(output)

  with open("data.picle","wb") as f:
    pickle.dump((words,labels,training,output),f)

ops.reset_default_graph()

net=tflearn.input_data(shape=[None,len(training[0])])
net=tflearn.fully_connected(net,8)
net=tflearn.fully_connected(net,8)
net=tflearn.fully_connected(net,len(output[0]),activation='softmax')
net=tflearn.regression(net)

model=tflearn.DNN(net)
try:
  model.load("model.tflearn")
except:
  model=tflearn.DNN(net)
  model.fit(training,output,n_epoch=1000,batch_size=8,show_metric=True)
  model.save("model.tflearn")

def bag_of_words(s,words):
  bag=[0 for _ in range(len(words))]
  s_words=nltk.word_tokenize(s)
  s_words=[stemmer.stem(word.lower())for word in s_words]
  for se in s_words:
    for i,w in enumerate(words):
      if w==se:
        bag[i] = 1
  return np.array(bag)


def chat(inp):
  if inp.lower()=="quit" or inp.lower()=="bye":
      return ""

  results=model.predict([bag_of_words(inp,words)])
  results_index=np.argmax(results)
  tag=labels[results_index]

  for tg in data["intents"]:
    if tg["tag"]==tag:
      response=tg['responses']

  corpus_text = listToString(response)
  return answer(corpus_text,inp) 

def listToString(response):
   
    str1 = " "
    return (str1.join(response))
  
def answer(corpus_text,inp):
  corpus_sentences=nltk.sent_tokenize(corpus_text)
  corpus_words=nltk.word_tokenize(corpus_text)

  wn_lemmatizer = nltk.stem.WordNetLemmatizer()

  def lemmatize_data(tokens):
    return [wn_lemmatizer.lemmatize(token) for token in tokens]

  punct_remover=dict((ord(punctuation),None) for punctuation in string.punctuation)

  def get_processed_data(data):
    return lemmatize_data(nltk.word_tokenize(data.lower().translate(punct_remover)))

  corpus_sentences.append(inp)

  word_vectorizer=TfidfVectorizer(tokenizer=get_processed_data)
  corpus_word_vectors=word_vectorizer.fit_transform(corpus_sentences)
  cos_sin_vectors=cosine_similarity(corpus_word_vectors[-1],corpus_word_vectors)
  similar_response_idx=cos_sin_vectors.argsort()[0][-2]

  return corpus_sentences[similar_response_idx]