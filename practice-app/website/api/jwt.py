from functools import wraps
from flask import jsonify
from flask_jwt_extended import get_jwt, verify_jwt_in_request

def artist_required():
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            verify_jwt_in_request()
            claims = get_jwt()
            print(claims)
            if claims["user_type"] == "artist":
                return fn(*args, **kwargs)
            else:
                return jsonify(msg="Only artists can view this page."), 403

        return decorator

    return wrapper

def user_required():
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            verify_jwt_in_request()
            claims = get_jwt()
            if claims["user_type"] == "user":
                return fn(*args, **kwargs)
            else:
                return jsonify(msg="Only users can view this page."), 403

        return decorator

    return wrapper
