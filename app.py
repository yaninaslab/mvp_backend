from email.mime import image
import dbinteractions as dbi
from flask import Flask, request, Response
import json
import hashlib

import sys

app = Flask(__name__)


@app.post('/api/users')
def signup_user():
    try:
        # Requesting data from the frontend
        f_name = request.json['firstName']
        l_name = request.json['lastName']
        email = request.json['email']
        password = request.json['password']
        phone = request.json['phone']
        # Here we are assigning variables that would be returned by a function that takes arguments in the brackets
        new_user, login_token, user_id = dbi.signup_user(
            f_name, l_name, email, password, phone)
        # This is a condition saying that if the function returns a 'new_user' we're accepting it as an object and converting it to json
        if(new_user == True):
            new_user = {
                "userId": user_id,
                "firstName": f_name,
                "lastName": l_name,
                "email": email,
                "phone": phone,
                "loginToken": login_token
            }
            new_user_json = json.dumps(new_user, default=str)
            # Returning response in json and request status
            return Response(new_user_json, mimetype="application/json", status=200)
        else:
            return Response("Please enter valid data", mimetype="plain/text", status=400)
# In case of error this will be returned
    except:
        print("Something went wrong")
        return Response("Sorry, something is wrong with the service. Please try again later", mimetype="plain/text", status=501)


@app.patch('/api/users')
def update_user():
    try:
        # Requesting data from the frontend
        login_token = request.json['loginToken']
        f_name = request.json['firstName']
        l_name = request.json['lastName']
        email = request.json['email']
        password = request.json['password']
        phone = request.json['phone']
        # Here we are assigning variables that would be returned by a function that takes arguments in the brackets
        success, user, user_id = dbi.update_user(login_token,
                                                 f_name, l_name, email, password, phone)
        # In case of a success we convert the user into an object and then to json
        if(success == True):
            user = {
                "userId": user_id,
                "firstName": user[1],
                "lastName": user[2],
                "email": user[3],
                "phone": user[4],
            }
            user_json = json.dumps(user, default=str)
            # Returning response in json and request status
            return Response(user_json, mimetype="application/json", status=200)
        else:
            return Response("Please enter valid data", mimetype="plain/text", status=400)
# In case of error this will be returned
    except:
        print("Something went wrong")
        return Response("Sorry, something is wrong with the service. Please try again later", mimetype="plain/text", status=501)


@app.delete('/api/users')
def delete_user():
    try:
        # Requesting data from the frontend
        user_id = request.json['userId']
        # We assign a variable to the function output and if it's true, we convert the data into json
        user_id = dbi.delete_user(user_id)
        if(user_id == True):
            user_id_json = json.dumps(user_id, default=str)
            # Returning response in json and request status
            return Response(user_id_json, mimetype="application/json", status=200)
        else:
            return Response("Please enter valid data", mimetype="plain/text", status=400)
# In case of error this will be returned
    except:
        print("Something went wrong")
        return Response("Sorry, something is wrong with the service. Please try again later", mimetype="plain/text", status=501)


if(len(sys.argv) > 1):
    mode = sys.argv[1]
else:
    print("You must pass a mode to run this python script. Either testing or production")
    exit()

if(mode == "testing"):
    print("Running in testing mode")
    from flask_cors import CORS
    CORS(app)
    app.run(debug=True)
elif(mode == "production"):
    print("Running in production mode")
    import bjoern  # type: ignore
    bjoern.run(app, "0.0.0.0", 5006)
else:
    print("Please run with either testing or production. Example:")
    print("python3.10 app.py production")
