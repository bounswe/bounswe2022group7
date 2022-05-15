from pickletools import read_unicodestring1
from flask import Blueprint, render_template

views = Blueprint('views', __name__)

@views.route("/")
def home():
    return render_template("home.html")

@views.route("event/<event_id>/")
def view_event(event_id):
    return render_template("view_event.html", event_id = event_id)

@views.route("create_event/")
def create_event():
    return render_template("create_event.html")

# @views.route("/forum_comment_post/")
# def forum_comment_post():
#     return render_template("forum_comment_post.html")

@views.route("discussion_post/<discussion_post_id>")
def discussion_post(discussion_post_id):
    return render_template("forum_post.html", discussion_post_id = discussion_post_id )
