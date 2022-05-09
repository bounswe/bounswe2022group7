from flask import Blueprint, render_template

views = Blueprint('views', __name__)

@views.route("/")
def home():
    return render_template("home.html")

@views.route("event/<event_id>/")
def view_event(event_id):
    return render_template("view_event.html", event_id = event_id)