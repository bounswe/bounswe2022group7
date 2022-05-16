import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

from flask_jwt_extended import JWTManager

db = SQLAlchemy()
DB_NAME = "database.db"


def create_app():
    app = Flask(__name__)

    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + \
        os.path.join(basedir, DB_NAME)
    
    app.config["JWT_SECRET_KEY"] = "super-secret"  # Change this!
    app.secret_key = "super-secret-2" # Change this! This is for flask session
    jwt = JWTManager(app)

    @jwt.user_identity_loader
    def user_identity_lookup(user):
        return user.id

    from .models import User

    @jwt.user_lookup_loader
    def user_lookup_callback(_jwt_header, jwt_data):
        identity = jwt_data["sub"]
        return User.query.filter_by(id=identity).one_or_none()

    db.init_app(app)

    from .views import views
    from .api.event import event
    from .api.home import home
    from .jwt import token
    from .api.discussion_forum import forum

    app.register_blueprint(views, url_prefix="/")
    app.register_blueprint(home, url_prefix="/api")
    app.register_blueprint(event, url_prefix="/api")
    app.register_blueprint(token, url_prefix="/token")
    app.register_blueprint(forum, url_prefix="/api")

    from .api.auth import auth

    app.register_blueprint(auth, url_prefix="/api/")

    create_database(app)

    return app


def create_database(app):
    if not os.path.exists('website/database/' + DB_NAME):
        db.create_all(app=app)