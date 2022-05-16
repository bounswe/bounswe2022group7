from flask import Blueprint, render_template, request

from .jwt import artist_token_required, user_token_required

views = Blueprint('views', __name__)


@views.route("/")
def home():
    token = request.args.get("token")
    return render_template("home.html", token=token)




@views.route("event/<event_id>/")
def view_event(event_id):
    return render_template("view_event.html", event_id=event_id)

@views.route("create_event/")
@artist_token_required
def create_event():
    return render_template("create_event.html")


@views.route("forum_get/")
def view_forum():
    return render_template("view_forum.html")


@views.route("forum_post/")
def post_forum():
    return render_template("post_forum.html")
