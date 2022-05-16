from . import db


class User(db.Model):
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
            "is_verified": self.is_verified
        }

    def get_name(self):
        return f"{self.first_name} {self.last_name}"


class Artist(db.Model):
    id = db.Column(db.Integer, db.ForeignKey("user.id"), primary_key=True)
    artistic_values = db.Column(db.Float)

    def serialize(self):
        return {
            "id": self.id,
            "artisitic_values": self.artistic_values
        }


class Admin(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(150))

    def serialize(self):
        return {
            "id": self.id,
            "username": self.username,
            "password": self.password
        }


class CopyrightReport(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.Text)
    description = db.Column(db.Text)

    responsible_admin = db.Column(db.Integer, db.ForeignKey(
        "admin.id"), primary_key=True)
    relevant_art_item = db.Column(
        db.Integer, db.ForeignKey("art_item.id"))

    def serialize(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "responsible_admin": self.responsible_admin,
            "relevant_art_item": self.relevant_art_item
        }


class Event(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.Text)
    description = db.Column(db.Text)
    poster_link = db.Column(db.Text)
    date = db.Column(db.Date)
    city = db.Column(db.Text)
    artist_id = db.Column(db.Integer, db.ForeignKey("artist.id"))

    def serialize(self):
        return {
            "id": self.id,
            "title": self.title,
            "description": self.description,
            "poster_link": self.poster_link,
            "date": self.date,
            "city": self.city,
            "artist_id": self.artist_id,
        }


class Participants(db.Model):
    event_id = db.Column(db.Integer, db.ForeignKey(
        "event.id"), primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), primary_key=True)

    def serialize(self):
        return {
            "event_id": self.event_id,
            "user_id": self.user_id
        }


class ArtItem(db.Model):
    __tablename__ = 'art_item'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(150))
    description = db.Column(db.Text)
    creator_artist = db.Column(db.Integer, db.ForeignKey("artist.id"))
    content_uri = db.Column(db.String)
    creation_date = db.Column(db.Date)

    def serialize(self):
        return {
            "id": self.id,
            "name": self.name,
            "description": self.description,
            "creator_artist": self.creator_artist,
            "content_uri": self.content_uri,
            "creation_date": self.creation_date
        }


"""
The database model for the discussion posts that are created under the separate forum page.
"""


class ForumPost(db.Model):
    __tablename__ = 'forum_post'
    id = db.Column(db.Integer, primary_key=True)
    creator = db.Column(db.Integer, db.ForeignKey("user.id"))
    title = db.Column(db.Text)
    description = db.Column(db.Text)
    content_uri = db.Column(db.String)
    creation_date = db.Column(db.Date)

    def serialize(self):
        return {
            "id": self.id,
            "creator": self.creator,
            "title": self.title,
            "description": self.description,
            "content_uri": self.content_uri,
            "creation_date": self.creation_date
        }


"""
The database model for the comments under forum posts.
"""


class PostComment(db.Model):
    __tablename__ = 'post_comment'
    parent_post = db.Column(db.Integer, db.ForeignKey("forum_post.id"))
    id = db.Column(db.Integer, primary_key=True)
    creator = db.Column(db.Integer, db.ForeignKey("user.id"))
    text = db.Column(db.Text)
    content_uri = db.Column(db.String)
    creation_date = db.Column(db.Date)

    def serialize(self):
        return {
            "parent_post": self.parent_post,
            "id": self.id,
            "creator": self.creator,
            "text": self.text,
            "content_uri": self.content_uri,
            "creation_date": self.creation_date
        }


"""
The database model for the comments under event pages.
"""


class EventDiscussionComment(db.Model):
    __tablename__ = 'event_comment'
    event = db.Column(db.Integer, db.ForeignKey("event.id"))
    id = db.Column(db.Integer, primary_key=True)
    creator = db.Column(db.Integer, db.ForeignKey("user.id"))
    text = db.Column(db.Text)
    creation_date = db.Column(db.Date)

    def serialize(self):
        return {
            "event": self.event,
            "id": self.id,
            "creator": self.creator,
            "text": self.text,
            "creation_date": self.creation_date
        }
