from flask import Blueprint, request
from flask_jwt_extended import current_user

from ..models import User
from .. import db

from .jwt import user_required

profile = Blueprint("profile", __name__)

# ROUTES

@profile.route("/profile/", methods=["GET"])
@user_required()
def get_profile():
    """
    file: ./doc/profile_GET.yml
    """
    user_id = current_user.id
    user = User.query.get(user_id)

    if not user:
        return {"error": f"There is no user with the id {user_id}."}, 404    

    user = user.serialize()
    del user["password"]

    return user, 200

# METHODS
