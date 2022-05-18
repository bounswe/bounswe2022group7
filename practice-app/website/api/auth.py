from flask import Blueprint, jsonify, request
from werkzeug.security import generate_password_hash, check_password_hash
from flask_jwt_extended import create_access_token

from .. import db
from ..models import User, Artist


auth = Blueprint('auth', __name__)


@auth.route('/signup', methods=['POST'])
def signup():
    email = request.json.get("email", None)
    password = request.json.get("password", None)
    first_name = request.json.get("first_name", None)
    last_name = request.json.get("last_name", None)
    is_artist = request.json.get("is_artist", None)

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
    if is_artist:
        new_artist = Artist(id=new_user.id, artistic_values=0)
        db.session.add(new_artist)
        db.session.commit()

    is_artist = is_artist!=None
    access_token = create_access_token(identity=new_user, additional_claims={"is_artist": is_artist})
    return jsonify(access_token=access_token, is_artist=is_artist), 201


@auth.route('/login', methods=['POST'])
def login():
    email = request.json.get("email", None)
    password = request.json.get("password", None)

    user = User.query.filter_by(email=email).first()
    if not user or not check_password_hash(user.password, password):
        return {'error': 'Incorrect email or password.'}, 401

    artist = Artist.query.get(user.id)

    is_artist = artist!=None
    access_token = create_access_token(identity=user, additional_claims={"is_artist": is_artist})
    return jsonify(access_token=access_token, is_artist=is_artist), 200
