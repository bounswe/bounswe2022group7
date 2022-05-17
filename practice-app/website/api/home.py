from flask import Blueprint, request, jsonify

from ..models import Event, ArtItem

home = Blueprint("home", __name__)

@home.route("/search", methods=["GET"])
def home_route():
    query = request.args.get("query", None)
    if query:
        events, art_items = get_content_with_filter(query)
    else:
        events, art_items = get_all_content()

    json = {"events": events, "art_items": art_items}
    json = {key:[i.serialize() for i in json[key]] for key in json}

    return json, 200


# METHODS

def get_content_with_filter(query):
    search = f"%{query}%"
    events = Event.query.filter(
        Event.title.like(search),
        Event.description.like(search)
    ).all()

    art_items = ArtItem.query.filter(
        ArtItem.name.like(search),
        ArtItem.description.like(search)
    ).all()

    return events, art_items

def get_all_content():
    events = Event.query.order_by(Event.id.desc()).all()
    art_items = ArtItem.query.order_by(ArtItem.id.desc()).all()

    return events, art_items
