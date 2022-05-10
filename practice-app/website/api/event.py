from flask import Blueprint, request
from datetime import datetime

from ..models import Event
from .. import db

event = Blueprint("event", __name__)

@event.route("/create_event", methods=["POST"])
def create_event():

    body = request.json

    title = body["title"]
    description = body["description"]
    poster_link = body["poster_link"]
    date = body["date"]
    city = body["city"]

    event = Event.query.filter_by(title=title).first()
    if event:
        return {"error": "Please enter a title that doesn't exist in the platform."}, 409

    new_event = Event(
        title = title,
        description = description,
        poster_link = poster_link,
        date = datetime.strptime(date, "%Y-%m-%d"),
        city = city
    )

    db.session.add(new_event)
    db.session.commit()

    return {"id": new_event.id}, 201

@event.route("/view_event", methods=["GET"])
def view_event():

    event_id = request.args.get("event_id")
    event = Event.query.get(event_id)

    if not event:
        return {"error": f"There are no events with the id {event_id}."}, 404    

    return event.serialize(), 201