from functools import wraps
from flask import Blueprint, request, session, redirect, url_for
from flask_jwt_extended import decode_token

# Token Blueprint

token = Blueprint("token", __name__)

@token.route("/set", methods=["POST"])
def set_session_token():

    access_token = request.json["access_token"]
    is_artist    = request.json["is_artist"]

    if token:
        __set_session(access_token, is_artist)
        return {"success": "Token succesfully set."}, 200
    else:
        return {"success": "A token should be provided in the request body."}, 400

@token.route("drop", methods=["POST"])
def drop_session_token():
    current_token = session.get("access_token", None)
    if current_token:
        __pop_session()
        return {"success": "Token removed from session."}, 200
    else:
        return {"error": "There is no token to remove from the session."}, 404

# Decorators

def artist_token_required(func):
    @wraps(func)
    def wrapped(*args, **kwargs):
        token = session.get("access_token", None)
        if not token:
            return redirect(url_for("views.no_token_info"))
        try:
            claim = decode_token(token)
            if not claim["is_artist"]:
                return {"error": "Wrong user type."}, 403
        except:
            __pop_session()
            return redirect(url_for("views.no_token_info"))
        return func(*args, **kwargs)
    return wrapped

def user_token_required(func):
    @wraps(func)
    def wrapped(*args, **kwargs):
        token = session.get("access_token", None)
        if not token:
            return redirect(url_for("views.no_token_info"))
        try:
            decode_token(token)
        except:
            __pop_session()
            return redirect(url_for("views.no_token_info"))
        return func(*args, **kwargs)
    return wrapped

# Helper Methods

def __set_session(access_token, is_artist):
    session["access_token"] = access_token
    session["is_artist"]    = is_artist

def __pop_session():
    session["access_token"] = None
    session["is_artist"] = None
