from flask import Blueprint, request, jsonify
from requests import session

from ..models import Event, ArtItem, CopyrightInfringementReport, verificationRequest

home = Blueprint("home", __name__)


@home.route("/search", methods=["GET"])
def home_route():
    """
    file: ./doc/home_GET.yml
    """
    query = request.args.get("query", None)
    verification_requests = {}
    if query:
        events, art_items, copyright_reports = get_content_with_filter(query)
    else:
        events, art_items, verification_requests, copyright_reports = get_all_content()

    json = {"events": events, "art_items": art_items, "copyright_reports": copyright_reports, "verification_requests": verification_requests}
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

    copyright_reports = CopyrightInfringementReport.query.filter(
        CopyrightInfringementReport.description.like(search)
    ).all

    return events, art_items, copyright_reports

def get_all_content():
    events = Event.query.order_by(Event.id.desc()).all()
    art_items = ArtItem.query.order_by(ArtItem.id.desc()).all()
    copyright_reports = CopyrightInfringementReport.query.order_by(CopyrightInfringementReport.id.desc()).limit(5).all()

    verification_requests = verificationRequest.query.order_by(verificationRequest.request_date.asc()).filter(
        verificationRequest.status==0
    ).all()

    return events, art_items, verification_requests, copyright_reports
