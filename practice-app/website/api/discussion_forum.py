# import logging
from flask import Blueprint, jsonify, request
from flask_jwt_extended import current_user
from .. import db
from ..models import ForumPost, PostComment, User
from flask_sqlalchemy import SQLAlchemy
from datetime import date
import json
import requests
from ..settings import *
from .jwt import artist_required, user_required

forum = Blueprint('forum', __name__)


@forum.route('/forum_get', methods=["GET"])
def forum_get():
    forums = ForumPost.query.all()
    result = map(lambda x: x.serialize(), forums)
    return jsonify(results=list(result))


@forum.route('/forum_post', methods=["POST"])
def forum_post():

    body = request.json

    title = body["title"]
    description = body["description"]
    content_uri = body["content_uri"]
    creator = body["creator"]

    new_post = ForumPost(
        creator=creator,
        title=title,
        description=description,
        content_uri=content_uri,
        creation_date=date.today()
    )

    db.session.add(new_post)
    db.session.commit()

    return {"id": new_post.id}, 201

@forum.route('/forum_comment_post', methods=["POST"])
@user_required()
def forum_comment_post():
    
    """
    file: ./doc/forum_comment_POST.yml
    """

    body = request.json
    # Tries to handle key/value errors 
    try:
        # parses the values for keys
        parent_post = body["parent_post"]
        text = body["text"]
        content_uri = body["content_uri"]
    except:
        return {"error": "There was an error on key / value pairs on request body."}, 400

    if not text:
        return {"error": "You have not provided body of the comment text"}, 400
    if not parent_post:
        return {"error": "Parent post id is empty"}, 400

    new_post_comment = PostComment(
        parent_post=parent_post,
        text=text,
        content_uri=content_uri,
        translation=translate(text),
        creator=current_user.id,
        creation_date=date.today()
    )

    # Tries to add the new post comment
    try:
        db.session.add(new_post_comment)
    except:
        return {"error" : f"There was an error adding the comment."}, 500


    # Handles DB commit
    try:
        db.session.commit()
    except Exception as error:
        return {"error" : f"Database commit error: {error}"}, 500

    return {"id": new_post_comment.id}, 201

@forum.route('/get_discussion_post/<post_id>', methods=["GET"])
def get_discussion_post(post_id):

    """
    file: ./doc/discussion_post_comments_GET.yml
    """

    post = ForumPost.query.get(post_id)

    if not post:
        return {"error": f"There is no post with the id {post_id}."}, 404 
    post = post.serialize()
    post["user_name"]  = User.query.get(post["creator"]).get_name()
    comments = PostComment.query.filter(PostComment.parent_post == post_id).all()

    def comment_info(x):
        comment = x.serialize()
        name = User.query.get(x.serialize()["creator"]).get_name()
        comment["name"] = name
        return comment


    result = list(map( comment_info, comments))
    return jsonify({"comments": result, "post": post}), 200


def translate(body):

    payload = {
	"source": "en",
	"target": "tr",
    "q": body
    }

    url = "https://deep-translate1.p.rapidapi.com/language/translate/v2"

    headers = {
        "content-type": "application/json",
        "X-RapidAPI-Host": "deep-translate1.p.rapidapi.com",
        "X-RapidAPI-Key": os.environ.get("TRANSLATE_API_KEY")
    }

    response = requests.request("POST", url, json=payload, headers=headers)

    if response.status_code == 429:
        return "You have exceeded the MONTHLY quota for Characters for Translate API. Try later."
    # print(response.json())

    return response.json()["data"]["translations"]["translatedText"]


