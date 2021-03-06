#####
# This file implements API endpoints for copyright infringement features
# @author: Ali Can Milani
#####

from flask import Blueprint, request
from flask_jwt_extended import current_user, verify_jwt_in_request
from datetime import date

from .. import db
import requests

from .jwt import user_required

from ..models import User, ArtItem, CopyrightInfringementReport

copyright = Blueprint("copyright", __name__)

# API endpoint for reporting a copyright infringement
@copyright.route("/copyright", methods=["POST"])
@user_required()
def report_infringement():

    """
    file: ./doc/copyright_POST.yml
    """

    # Checking if the request body is JSON
    if (not request.is_json):
        return {"error": "Request body should be a JSON file."}, 400
    
    request_json = request.get_json()
    
    # Checking if the request JSON has all the required fields 
    if (is_missing_field(request_json, {"original_art_item_id", "infringement_art_item_id", "description"})):
        return {"error": "You have not provided some of the required fields."}, 400

    # Quering for given art items URIs
    original_art_item = ArtItem.query.get(request_json["original_art_item_id"])
    infringement_art_item = ArtItem.query.get(request_json["infringement_art_item_id"])

    if(not original_art_item):
        return {"error": f"Art Item with id : {request_json['original_art_item_id']} does not exists."}, 404
    if(not infringement_art_item):
        return {"error": f"Art Item with id : {request_json['infringement_art_item_id']} does not exists."}, 404

    # Checking if the given art items are different
    if (request_json["original_art_item_id"] == request_json["infringement_art_item_id"]):
        return {"error": "Original art item and infringement art item must be different."}, 400

    # Getting a similarity score by calling an external API to compare two images
    #   Smaller the value, similar the images
    sim_score = get_similarity_score(original_art_item.content_uri, infringement_art_item.content_uri)

    if (sim_score == -1):
        return {"error": "Something went wrong in the external Image Similarity API. Please try again."}, 400

    verify_jwt_in_request()

    new_copyright_report = CopyrightInfringementReport(
        creator = current_user.id,
        original_art_item_id = request_json["original_art_item_id"],
        infringement_art_item_id = request_json["infringement_art_item_id"],
        description = request_json["description"],
        similarity_score = sim_score,
        creation_date = date.today()
    )

    # Creating the report and commiting it 
    try:
        db.session.add(new_copyright_report)
        db.session.commit()
    except Exception as error:
        return {"error" : f"There was an error adding the copyright infringement report to the database, Error: {error}."}, 500

    # Success
    return {"id": new_copyright_report.id}, 201

# API endpoint for viewing a copyright infringement report
@user_required()
@copyright.route("/copyright/<report_id>", methods=["GET"])
def get_copyright_report_data(report_id):

    """
    file: ./doc/copyright_GET.yml
    """

    report = CopyrightInfringementReport.query.get(report_id)

    # Checking if report with given id exists
    if not report:
        return {"error": f"There are no reports with the id {report_id}."}, 404    

    report = report.serialize()

    # Giving the name of the reoprt creator to the frontend
    report["creator_name"]  = User.query.get(report["creator"]).get_name()

    # Giving relevant art items data to the frontend
    original_art_item = ArtItem.query.get(report["original_art_item_id"])
    infringement_art_item = ArtItem.query.get(report["infringement_art_item_id"])

    report["original_art_name"]  = original_art_item.name
    report["original_art_creation_date"]  = original_art_item.creation_date
    report["original_art_uri"]  = original_art_item.content_uri
    report["infringement_art_name"]  = infringement_art_item.name
    report["infringement_art_creation_date"]  = infringement_art_item.creation_date
    report["infringement_art_uri"]  = infringement_art_item.content_uri

    return report, 200


# API endpoint for removing an art item
@user_required()
@copyright.route("/copyright", methods=["DELETE"])
def remove_art_item():

    """
    file: ./doc/copyright_DELETE.yml
    """

    # Checking if the request body is JSON
    if (not request.is_json):
        return {"error": "Request body should be a JSON file."}, 400
    
    request_json = request.get_json()

    # Checking if the request JSON has all the required fields 
    if (is_missing_field(request_json, {"art_item_id"})):
        return {"error": "You have not provided some of the required fields."}, 400

    art_item = ArtItem.query.get(request_json["art_item_id"])
    if (not art_item):
        return {"error": f"There are no Art Item with the id {request_json['art_item_id']}."}, 404

    # Removing the art item and commiting it 
    # removing the art item will remove the related copyright reports as its configured as delete on cascade
    try:
        db.session.delete(art_item)
        db.session.commit()
    except Exception as error:
        return {"error" : f"There was an error removing the art item from the database, Error: {error}."}, 500

    # Success
    return {"id": request_json["art_item_id"]}, 200

# Methods
def is_missing_field(json, required_set):
    missing_fields = required_set - set(json.keys())
    return len(missing_fields) > 0

from ..settings import SIMILARITY_SCORE_API_KEY

def get_similarity_score(image1, image2):

    # External API to compare two images
    # https://deepai.org/machine-learning-model/image-similarity
    
    response = requests.post(
        "https://api.deepai.org/api/image-similarity",
        data={
            'image1': image1,
            'image2': image2,
        },
        headers={'api-key': SIMILARITY_SCORE_API_KEY}
    )

    # Calling the API 2 aditional times if it fails to give a score
    # This is because API is not working consistantly with higher resolution image URIs
    counter = 2
    while (response.status_code != 200) and counter > 0:
        response = requests.post(
            "https://api.deepai.org/api/image-similarity",
            data={
                'image1': image1,
                'image2': image2,
            },
            headers={'api-key': SIMILARITY_SCORE_API_KEY}
        )
        counter -= 1


    if response.status_code == 200:
        response_json = response.json()
        return response_json["output"]["distance"]

    # Something went wrong in the External API
    else:
        return -1