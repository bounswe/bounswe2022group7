import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy

from flask_jwt_extended import JWTManager

from flasgger import Swagger

db = SQLAlchemy()
DB_NAME = "database.db"


def create_app(db_name = DB_NAME):
    app = Flask(__name__)

    app.config['SWAGGER'] = {
        'title': 'Practice App API',
        'version': '1.0',
        'description': 'API for Practice Application of Group 7. A collaborative art platform, ArtShare.',
    }

    swagger_template = {
        "securityDefinitions": {
            "BearerAuth": {
                "type": "apiKey",
                "name": "Authorization",
                "in": "header"
            }
        }
    }

    swagger = Swagger(app, template=swagger_template)

    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + \
        os.path.join(basedir, db_name)

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
    from .api.art_item import art_item
    from .api.home import home
    from .jwt import token
    from .api.art_galleries import art_galleries

    app.register_blueprint(views, url_prefix="/")
    app.register_blueprint(home, url_prefix="/api")
    app.register_blueprint(event, url_prefix="/api")
    app.register_blueprint(art_item, url_prefix="/api")
    app.register_blueprint(token, url_prefix="/token")
    app.register_blueprint(art_galleries, url_prefix='/api')

    from .api.auth import auth

    app.register_blueprint(auth, url_prefix="/api/")

    create_database(app)

    return app


def create_database(app):
    if not os.path.exists('website/database/' + DB_NAME):
        db.create_all(app=app)
