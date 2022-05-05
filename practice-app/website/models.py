from . import db
from flask_login import UserMixin


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(150))
    first_name = db.Column(db.String(150))
    last_name = db.Column(db.String(150))
    is_verified = db.Column(db.Boolean)

    def serialize(self):  # returns object data in JSON serialized format
        return {
            "id": self.id,
            "email": self.email,
            "password": self.password,
            "first_name": self.first_name,
            "last_name": self.last_name,
            "is_verified": self.is_verified,
        }


class Artist(db.Model):
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), primary_key=True)
    artisitic_values = db.Column(db.Float)

    def serialize(self):
        return {
            "event_id": self.event_id,
            "artisitic_values": self.artisitic_values,
        }


class Event(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.Text)
    event_time = db.Column(db.Date)
    formatted_address = db.Column(db.Text)
    entered_address = db.Column(db.Text)
    longitude = db.Column(db.Float())
    latitude = db.Column(db.Float())
    creator_artist = db.Column(db.Integer, db.ForeignKey("artist.id"))
    description = db.Column(db.Text)

    def serialize(self):
        return {
            "id": self.id,
            "title": self.title,
            "event_time": self.event_time,
            "formatted_address": self.formatted_address,
            "entered_address": self.entered_address,
            "longitude": self.longitude,
            "latitude": self.latitude,
            "creator_artist": self.creator_artist,
            "description": self.description,
        }


class Participants(db.Model):
    event_id = db.Column(db.Integer, db.ForeignKey("event.id"), primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), primary_key=True)

    def serialize(self):
        return {
            "event_id": self.event_id,
            "user_id": self.user_id,
        }
