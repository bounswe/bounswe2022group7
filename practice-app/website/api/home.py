from flask import Blueprint, request, jsonify
from requests import session

from ..models import Event, ArtItem, CopyrightInfringementReport

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

        copyright_reports = CopyrightInfringementReport.query.filter(
            CopyrightInfringementReport.description.like(search)
        ).all

    else:
        events = Event.query.order_by(Event.id.desc()).limit(5).all()
        art_items = ArtItem.query.order_by(ArtItem.id.desc()).limit(5).all()
        copyright_reports = CopyrightInfringementReport.query.order_by(CopyrightInfringementReport.id.desc()).limit(5).all()

    json = {"events": events, "art_items": art_items, "copyright_reports": copyright_reports}
    json = {key:[i.serialize() for i in json[key]] for key in json}

    return json, 201


