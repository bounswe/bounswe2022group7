
from __future__ import print_function
from http.client import INTERNAL_SERVER_ERROR
from flask import Blueprint, jsonify, request
from website import db
from website.models import ForumPost
from datetime import date
import requests
from flask_jwt_extended import current_user
from website.settings import *

from .jwt import user_required

forum = Blueprint('forum', __name__)


def bad_word_check(body):
    url = "https://www.purgomalum.com/service/json"

    querystring = {"text": body}

    try:
        response = requests.request(
            "GET", url, params=querystring)
        json = response.json()
        if "result" not in json:
            return {"result": body}
        else:
            return json
    except requests.exceptions.RequestException as e:
        forum.logger.error(
            "Error occured while consulting an external api for censoring.")
        return {"result": body}


@forum.route('/forum_get/', methods=["GET"])
def forum_get():

    """
    file: ./doc/forum_get_GET.yml
    """
    
    try:
        forums = ForumPost.query.all()
    except INTERNAL_SERVER_ERROR:
        return {"error": "Error while extracting posts from database."}, 500
    result = map(lambda x: x.serialize(), forums)
    return jsonify(results=list(result)), 200


@forum.route('/forum_post/', methods=["POST"])
@user_required()
def forum_post():

    """
    file: ./doc/forum_post_POST.yml
    """

    body = request.json

    if body["description"] == "":
        return {"error": f"You have not provided body of the post"}, 400

    title = body["title"]
    description = bad_word_check(body["description"])
    content_uri = body["content_uri"]
    creator = current_user.email

    new_post = ForumPost(
        creator=creator,
        title=title,
        description=description["result"],
        content_uri=content_uri,
        creation_date=date.today()
    )
    try:
        db.session.add(new_post)
        db.session.commit()
        return {"id": new_post.id}, 201
    except INTERNAL_SERVER_ERROR:
        return {"error": "Error recording post to database."}, 500
