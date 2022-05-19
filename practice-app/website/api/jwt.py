from functools import wraps
from flask import jsonify
from flask_jwt_extended import get_jwt, verify_jwt_in_request


def artist_required():
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            verify_jwt_in_request()
            claims = get_jwt()
            if claims["is_artist"]:
                return fn(*args, **kwargs)
            else:
                return jsonify(msg="You can only access this API endpoint with a valid artist token."), 403

        return decorator

    return wrapper


def user_required():
    def wrapper(fn):
        @wraps(fn)
        def decorator(*args, **kwargs):
            verify_jwt_in_request()
            claims = get_jwt()
            return fn(*args, **kwargs)
        return decorator

    return wrapper
