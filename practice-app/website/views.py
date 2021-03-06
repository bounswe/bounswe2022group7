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


@views.route("verification/<request_id>/")
def viewRequest(request_id):
    print(request_id)
    return render_template("view_verification_request.html", request_id=request_id)

@views.route("create_event/")
@artist_token_required
def create_event():
    return render_template("create_event.html")

@views.route("wikipedia_definition/")
def wikipedia_definition():
    return render_template("wikipedia_definition.html")

@views.route("/forum_comment_post/")
def forum_comment_post():
    return render_template("forum_comment_post.html")

@views.route("discussion_post/<discussion_post_id>")
def discussion_post(discussion_post_id):
    return render_template("forum_post.html", discussion_post_id = discussion_post_id )


@views.route("forum_get/")
def view_forum():
    return render_template("view_forum.html")


@user_token_required
@views.route("forum_post/")
def post_forum():
    return render_template("post_forum.html")
@views.route("art_item/<art_item_id>/")
def view_art_item(art_item_id):
    return render_template("view_art_item.html", art_item_id=art_item_id)

@views.route("create_art_item/")
@artist_token_required
def create_art_item():
    return render_template("create_art_item.html")

@views.route("view_profile/")
@user_token_required
def view_profile():
    return render_template("view_profile.html")


@views.route('signup/')
def signup():
    return render_template('signup.html')


@views.route('login/')
def login():
    return render_template('login.html')

@views.route('participate/<event_id>/')
@user_token_required
def participate(event_id):
    return render_template('participate.html', event_id=event_id)
    
@views.route('request_verification/')
def request_verification():
    return render_template('request_verification.html')


@views.route('bootstrap_test')
def bootstrapTest():
    return render_template('bootstrap.html')

@views.route('art_galleries/')
def view_art_galleries():
    return render_template('art_galleries.html')

@views.route("no_token_info/")
def no_token_info():
    return render_template("info_page.html",
                           info=["You tried to access a page that requires authentication without a valid token.",
                                 "Either you didn't login or your session expired (15 minutes).",
                                 "Please login and try again."])  
  
@views.route("copyright/<report_id>/")
def view_copyright_report(report_id):
    return render_template("view_copyright_report.html", report_id=report_id)

@views.route("report_infringement/")
def report_infringement():
    return render_template("report_infringement.html")
