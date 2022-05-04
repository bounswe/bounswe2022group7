from . import db
from flask_login import UserMixin


class User(db.Model, UserMixin):  # ready to be implemented
    id = db.Column(db.Integer, primary_key=True)

    def serialize(self):  # returns object data in JSON serialized format
        return {
            'id': self.id,
        }
