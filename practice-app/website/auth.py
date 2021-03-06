from flask import Blueprint, jsonify, request
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import create_access_token, jwt_required, current_user

from . import db
from .models import User


auth = Blueprint('auth', __name__)


@auth.route('/signup', methods=['POST'])
def signup():
    email = request.json.get("email", None)
    password = request.json.get("password", None)
    first_name = request.json.get("first_name", None)
    last_name = request.json.get("last_name", None)

    user = User.query.filter_by(email=email).first()
    if user:
        return {'error': 'This email is already taken.'}, 409

    new_user = User(
        email=email,
        password=generate_password_hash(password, method='sha256'),
        first_name=first_name,
        last_name=last_name,
        is_verified=False)

    db.session.add(new_user)
    db.session.commit()

    access_token = create_access_token(identity=new_user)
    return jsonify(access_token=access_token)


@auth.route('/login', methods=['POST'])
def login():
    email = request.json.get("email", None)
    password = request.json.get("password", None)

    user = User.query.filter_by(email=email).first()
    if not user or not check_password_hash(user.password, password):
        return {'error': 'Incorrect email or password.'}, 401

    access_token = create_access_token(identity=user)
    return jsonify(access_token=access_token)


@auth.route("/protected", methods=["GET"])
@jwt_required()
def protected():
    return jsonify(logged_in_as=current_user.email), 200
