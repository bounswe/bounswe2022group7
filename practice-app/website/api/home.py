from flask import Blueprint, request, jsonify

from ..models import Event, ArtItem

home = Blueprint("home", __name__)

@home.route("/search", methods=["GET"])
def home_route():
    query = request.args.get("query", None)
    if query:
        search = f"%{query}%"
        events = Event.query.filter(
            Event.title.like(search),
            Event.description.like(search)
        ).all()

        art_items = ArtItem.query.filter(
            ArtItem.name.like(search),
            ArtItem.description.like(search)
        ).all()

    else:
        events = Event.query.order_by(Event.id.desc()).all()
        art_items = ArtItem.query.order_by(ArtItem.id.desc()).all()

    json = {"events": events, "art_items": art_items}
    json = {key:[i.serialize() for i in json[key]] for key in json}

    return json, 200


