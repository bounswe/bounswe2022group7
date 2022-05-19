import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager

from flasgger import Swagger

from datetime import timedelta
from .settings import DB_NAME, FLASK_SECRET_KEY, JWT_SECRET_KEY

db = SQLAlchemy()

def create_app(testing = False):
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


    app.config['PERMANENT_SESSION_LIFETIME'] =  timedelta(minutes=15)
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    # CONFIGURATION HANDLING
    if (testing):
        app.secret_key = "super-secret-2"  #This is for flask session
        app.config["JWT_SECRET_KEY"] = "super-secret"  # Change this!
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
    else:
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + \
            os.path.join(basedir, DB_NAME)
        app.secret_key = FLASK_SECRET_KEY  #This is for flask session
        app.config["JWT_SECRET_KEY"] = FLASK_SECRET_KEY  # Change this!
    
    
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
    from .api.profile import profile
    from .jwt import token
    from .api.discussion_forum import forum
    from .api.art_galleries import art_galleries

    app.register_blueprint(views, url_prefix="/")
    app.register_blueprint(home, url_prefix="/api")
    app.register_blueprint(event, url_prefix="/api")
    app.register_blueprint(art_item, url_prefix="/api")
    app.register_blueprint(profile, url_prefix="/api")
    app.register_blueprint(token, url_prefix="/token")
    app.register_blueprint(forum, url_prefix="/api")
    app.register_blueprint(art_galleries, url_prefix='/api')

    from .api.verification import verify
    app.register_blueprint(verify, url_prefix="/api")

    from .api.auth import auth

    app.register_blueprint(auth, url_prefix="/api/")

    create_database(app)

    return app


def create_database(app):
    if not os.path.exists('website/database/' + DB_NAME):
        db.create_all(app=app)
