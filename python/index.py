#!/usr/bin/python3
from flask import Flask
import os
os.environ['HOST_NAME']
os.environ['MY_TAG']

TAG=os.getenv('MY_TAG')
HOST=os.getenv('HOST_NAME')
app = Flask(__name__)
@app.route("/")
def hello():
    return "Hello World! Application version {0} - Hostname {1}".format(TAG,HOST)  
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int("5000"), debug=True)
