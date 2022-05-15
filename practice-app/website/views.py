from flask import Blueprint, render_template, request

from .jwt import artist_token_required, user_token_required

views = Blueprint('views', __name__)


@views.route("/")
def home():
    token = request.args.get("token")
    return render_template("home.html", token=token)


@views.route("event/<event_id>/")
def view_event(event_id):
    token = request.args.get("token")
    return render_template("view_event.html", event_id=event_id, token=token)

@views.route("create_event/")
@artist_token_required
def create_event():
    token = request.args.get("token")
    return render_template("create_event.html", token=token)


@views.route('signup/')
def signup():
    return render_template('signup.html')


@views.route('login/')
def login():
    return render_template('login.html')
