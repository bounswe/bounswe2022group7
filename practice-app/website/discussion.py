from pickletools import read_unicodestring1
from flask import Blueprint, render_template

discussion = Blueprint('discussion', __name__)


@discussion.route("/")
def home():
    return render_template("home.html")


@discussion.route("/forum_get/")
def view_forum():
    return render_template("view_forum.html")


@discussion.route("/forum_post/")
def post_forum():
    return render_template("post_forum.html")
