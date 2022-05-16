import logging
from flask import Blueprint, jsonify, request
from .. import db
from ..models import ForumPost, PostComment
from flask_sqlalchemy import SQLAlchemy
from datetime import date
import json
import requests
from ..settings import *

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
def forum_comment_post():

    body = request.json

    parent_post = body["parent_post"]
    text = body["text"]
    content_uri = body["content_uri"]
    # creator = body["creator"]


    new_post_comment = PostComment(
        parent_post=parent_post,
        text=text,
        content_uri=content_uri,
        translation=translate(text),
        # creator=creator,
        creation_date=date.today()
    )

    db.session.add(new_post_comment)
    db.session.commit()

    return {"id": new_post_comment.id}, 201

@forum.route('/get_discussion_posts/<post_id>', methods=["GET"])
def get_discussion_posts(post_id):


    try:
        parent_post_id = request.args.get("post_id")
    except:
        return {"error": "Invalid arguments"}, 400

    post = ForumPost.query.get(post_id)

    comments = PostComment.query.filter(PostComment.parent_post == post_id).all()

    result = map(lambda x: x.serialize(), comments)
    return jsonify(comments=list(result), post=post.serialize()), 200


def translate(body):

    payload = {
	"source": "en",
	"target": "tr",
    "q": body
    }
    # payload["q"] = body

    url = "https://deep-translate1.p.rapidapi.com/language/translate/v2"

    headers = {
        "content-type": "application/json",
        "X-RapidAPI-Host": "deep-translate1.p.rapidapi.com",
        "X-RapidAPI-Key": os.environ.get("TRANSLATE_API_KEY")
    }

    response = requests.request("POST", url, json=payload, headers=headers)

    return response.json()["data"]["translations"]["translatedText"]


