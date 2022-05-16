from functools import wraps
from flask import Blueprint, request, session
from flask_jwt_extended import decode_token

# Token Blueprint

token = Blueprint("token", __name__)

@token.route("/set", methods=["POST"])
def set_session_token():

    access_token = request.json["access_token"]
    is_artist    = request.json["is_artist"]

    if token:
        session["access_token"] = access_token
        session["is_artist"]    = is_artist
        return {"success": "Token succesfully set."}, 200
    else:
        return {"success": "A token should be provided in the request body."}, 400

@token.route("drop", methods=["POST"])
def drop_session_token():
    current_token = session["access_token"] 
    if current_token:
        session["access_token"] = None
        session["is_artist"] = None
        return {"success": "Token removed from session."}, 200
    else:
        return {"error": "There is no token to remove from the session."}, 404

# Decorators

def artist_token_required(func):
    @wraps(func)
    def wrapped(*args, **kwargs):
        token = session["token"]
        if not token:
            return {"error": "You can not view this page without providing a valid token."}, 403
        try:
            claim = decode_token(token)
            if claim["user_type"] != "artist":
                return {"error": "Wrong user type."}, 403
        except:
            return {"error": "Invalid token."}, 403
        return func(*args, **kwargs)
    return wrapped

def user_token_required(func):
    @wraps(func)
    def wrapped(*args, **kwargs):
        token = session["token"]
        if not token:
            return {"error": "You can not view this page without providing a valid token."}, 403
        try:
            claim = decode_token(token)
            if claim["user_type"] != "user":
                return {"error": "Wrong user type."}, 403
        except:
            return {"error": "Invalid token."}, 403
        return func(*args, **kwargs)
    return wrapped