from functools import wraps
from flask import request
from flask_jwt_extended import decode_token


def artist_token_required(func):
    @wraps(func)
    def wrapped(*args, **kwargs):
        token = request.args.get("token")
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
        token = request.args.get("token")
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
