import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager



db = SQLAlchemy()
DB_NAME = "database.db"


def create_app():
    app = Flask(__name__)

    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + \
        os.path.join(basedir, DB_NAME)
    app.config['SECRET_KEY'] = 'secret-key-goes-here'

    db.init_app(app)

    from .views import views
    from .api.event import event
    from .api.participants import participants

    app.register_blueprint(views, url_prefix="/")
    app.register_blueprint(event, url_prefix="/api/")
    app.register_blueprint(participants, url_prefix="/api/")

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    from .models import User

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    from .auth import auth
    app.register_blueprint(auth)

    create_database(app)

    return app


def create_database(app):
    if not os.path.exists('website/database/' + DB_NAME):
        db.create_all(app=app)
