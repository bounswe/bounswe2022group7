#####
# This file implements API endpoints for copyright infringement features
# @author: Ali Can Milani
#####

from flask import Blueprint, request
from flask_jwt_extended import current_user
from datetime import date

from .. import db
import requests

from ..models import ArtItem, CopyrightInfringementReport

copyright = Blueprint("copyright", __name__)

# API endpoint for reporting a copyright infringement
@copyright.route("/copyright", methods=["POST"])
def report_infringement():

    # Checking if the request body is JSON
    if (not request.is_json):
        return {"error": "Request body should be a JSON file."}, 400
    
    request_json = request.get_json()
    
    # Checking if the request JSON has all the required fields 
    if (is_missing_field(request_json)):
        return {"error": "You have not provided some of the required fields."}, 400

    # Quering for given art items URIs
    original_art_id = request_json["original_art_item_id"]
    infringement_art_id = request_json["infringement_art_item_id"]

    if(not art_item_exists(original_art_id)):
        return {"error": f"Art Item with id : {original_art_id} does not exists."}, 409
    if(not art_item_exists(infringement_art_id)):
        return {"error": f"Art Item with id : {original_art_id} does not exists."}, 409
    
    original_image_uri = ArtItem.query.filter(ArtItem.id == original_art_id).first().content_uri
    infringement_image_uri = ArtItem.query.filter(ArtItem.id == infringement_art_id).first().content_uri

    # Getting a similarity score by calling an external API to compare two images
    #   Smaller the value, similar the images
    sim_score = get_similarity_score(original_image_uri, infringement_image_uri)

    if (sim_score == -1):
        return {"error": "Something went wrong in the external Image Similarity API."}, 400

    new_copyright_report = CopyrightInfringementReport(
        creator = current_user.id,
        original_art_item_id = request_json["original_art_item_id"],
        infringement_art_item_id = request_json["infringement_art_item_id"],
        description = request_json["description"],
        similarity_score = sim_score,
        creation_date = date.today()
        )

    try:
        db.session.add(new_copyright_report)
        db.session.commit()
    except Exception as error:
        return {"error" : f"There was an error adding the copyright infringement report to the database, Error: {error}."}, 500

    # Success
    return {"id": new_copyright_report.id}, 201


# Methods
def is_missing_field(json):
    missing_fields = {"original_art_item_id", "infringement_art_item_id", "description"} - set(json.keys())
    return len(missing_fields) > 0

def art_item_exists(id):
    item = ArtItem.query.filter_by(id=id).first()
    return item != None

def get_similarity_score(image1, image2):

    # External API to compare two images
    # https://deepai.org/machine-learning-model/image-similarity
    response = requests.post(
        "https://api.deepai.org/api/image-similarity",
        data={
            'image1': image1,
            'image2': image2,
        },
        headers={'api-key': 'quickstart-QUdJIGlzIGNvbWluZy4uLi4K'}
    )

    if response.status_code == 200:
        response_json = response.json()
        return response_json["output"]["distance"]

    # Something went wrong in the External API
    else:
        return -1