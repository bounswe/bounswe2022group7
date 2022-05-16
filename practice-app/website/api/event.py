from flask import Blueprint, request
from datetime import datetime

from ..models import Event
from .. import db

event = Blueprint("event", __name__)

# ROUTES

@event.route("/create_event", methods=["POST"])
def create_event():

    json = request.json

    missing_fields = {"title", "description", "poster_link", "date", "city"} - set(request.json.keys())
    if len(missing_fields) > 0:
        return {"error": f"You have not provided some of the required fields. You are missing: " + str(missing_fields)}, 400

    if title_exists(json["title"]):
        return {"error": "Please enter a title that doesn't exist in the platform."}, 409

    if not date_valid(json["date"]):
        return {"error": f"Date you have entered is not valid. Format is \"%Y-%m-%d\". You entered \"{json['date']}\"."}, 400

    event = create_event_record(json)

    db.session.add(event)
    db.session.commit()

    return {"id": event.id}, 201

@event.route("/view_event", methods=["GET"])
def view_event():

    event_id = request.args.get("event_id")
    event = Event.query.get(event_id)

    if not event:
        return {"error": f"There are no events with the id {event_id}."}, 404    

    return event.serialize(), 200

# METHODS

def is_missing_field(json):
    missing_fields = {"title", "description", "poster_link", "date", "city"} - set(request.json.keys())
    return len(missing_fields) > 0

def title_exists(title):
    event = Event.query.filter_by(title=title).first()
    return event != None

def date_valid(date):
    try:
        datetime.strptime(date, "%Y-%m-%d")
        return True
    except:
        return False

def create_event_record(json):
    title = json["title"]
    description = json["description"]
    poster_link = json["poster_link"]
    date = json["date"]
    city = json["city"]

    new_event = Event(
        title = title,
        description = description,
        poster_link = poster_link,
        date = datetime.strptime(date, "%Y-%m-%d"),
        city = city
    )

    return new_event

