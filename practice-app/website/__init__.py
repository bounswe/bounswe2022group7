import os

from flask import Flask
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()
DB_NAME = "database.db"


def create_app():
    app = Flask(__name__)

    basedir = os.path.abspath(os.path.dirname(__file__))
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + \
        os.path.join(basedir, DB_NAME)

    db.init_app(app)
    create_database(app)

    return app


def create_database(app):
    if not os.path.exists('website/database/' + DB_NAME):
        db.create_all(app=app)
