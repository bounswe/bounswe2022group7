from flask import Blueprint, jsonify, request
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from .models import User


auth = Blueprint('auth', __name__)

@auth.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    email = data['email']
    password = data['password']
    first_name = data['first_name']
    last_name = data['last_name']

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

    return {
        'email': new_user.email,
        'first_name': new_user.first_name,
        'last_name': new_user.last_name,
        'is_verified': new_user.is_verified
    }, 201

@auth.route('/login', methods=['POST'])
def login():
    pass

@auth.route('/logout')
def logout():
    pass