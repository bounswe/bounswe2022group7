import logging
from flask import Blueprint, jsonify, request
from .. import db
from ..models import ForumPost
from flask_sqlalchemy import SQLAlchemy
from datetime import date
import json
import requests

forum = Blueprint('forum', __name__)


def bad_word_check(body):
    url = "https://community-purgomalum.p.rapidapi.com/json"

    querystring = {"text":body}

    header = {
	    "X-RapidAPI-Host": "community-purgomalum.p.rapidapi.com",
	    "X-RapidAPI-Key": "818ef66db1msh776544fab719fb2p1d8998jsn85fa7e0d9fca"
    }

    response = requests.request("GET", url, headers=header, params=querystring)

    return response.json()
    

@forum.route('/forum_get', methods=["GET"])
def forum_get():
    forums = ForumPost.query.all()
    result = map(lambda x: x.serialize(), forums)
    return jsonify(results=list(result))




@forum.route('/forum_post', methods=["POST"])
def forum_post():

    body = request.json

    title = body["title"]
    description = bad_word_check(body["description"])
    content_uri = body["content_uri"]
    creator = body["creator"]
    

    new_post = ForumPost(
        creator=creator,
        title=title,
        description=description["result"],
        content_uri=content_uri,
        creation_date=date.today()
    )

    db.session.add(new_post)
    db.session.commit()

    return {"id": new_post.id}, 201


# https://realpython.com/flask-blueprint/
# https://stackoverflow.com/questions/37164675/clicking-button-with-requests
# https://www.w3schools.com/html/html_form_attributes.asp
# https://pythonbasics.org/flask-rest-api/
# https://www.digitalocean.com/community/tutorials/how-to-use-web-forms-in-a-flask-application
# https://stackoverflow.com/questions/65589254/how-do-i-have-a-login-form-with-multiple-post-and-get-requests-in-flask
# https://stackoverflow.com/questions/42018603/handling-get-and-post-in-same-flask-view
# https://stackoverflow.com/questions/50933079/html-form-data-into-flask-script-using-apis
# https://stackoverflow.com/questions/42499535/passing-a-json-object-from-flask-to-javascript
# https://www.digitalocean.com/community/tutorials/how-to-make-a-web-application-using-flask-in-python-3#step-2-creating-a-base-application
# https://stackoverflow.com/questions/12435297/how-do-i-jsonify-a-list-in-flask
# https://stackoverflow.com/questions/3916123/json-structure-for-list-of-objects
