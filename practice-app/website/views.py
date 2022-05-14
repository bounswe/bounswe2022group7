from pickletools import read_unicodestring1
from flask import Blueprint, render_template

views = Blueprint('views', __name__)


@views.route("/")
def home():
    return render_template("home.html")


@views.route("event/<event_id>/")
def view_event(event_id):
    return render_template("view_event.html", event_id=event_id)


@views.route("create_event/")
def create_event():
    return render_template("create_event.html")


@views.route("forum_get/")
def view_forum():
    return render_template("view_forum.html")


@views.route("forum_post/")
def post_forum():
    return render_template("post_forum.html")
