import requests
from ..settings import COLOR_FINDER_API_KEY, COLOR_FINDER_API_SECRET
from flask import Blueprint, request
from flask_jwt_extended import current_user
from datetime import datetime

from ..models import ArtItem, User
from .. import db

from .jwt import artist_required

art_item = Blueprint("art_item", __name__)


@art_item.route("/art_item/<art_item_id>", methods=["GET"])
def get_art_item_data(art_item_id):

    """
    file: ./doc/art_item_GET.yml
    """

    art_item = ArtItem.query.get(art_item_id)

    if not art_item:
        return {"error": f"There are no art items with the id {art_item_id}."}, 404

    art_item_data = art_item.serialize()

    #  find data that does not exist in the database, and return it
    art_item_data["artist_name"] = User.query.get(
        art_item_data["creator_artist"]).get_name()
    art_item_data["dominant_colors"] = get_dominant_colors(
        art_item_data["content_uri"])

    return art_item_data, 200


@art_item.route("/art_item", methods=["POST"])
@artist_required()
def create_art_item():

    """
    file: ./doc/art_item_POST.yml
    """

    json = request.json

    missing_fields = {"name", "description",
                      "content_uri"} - set(request.json.keys())
    if len(missing_fields) > 0:
        return {"error": f"You have not provided some of the required fields. You are missing: " + str(missing_fields)}, 400

    if name_exists(json["name"]):
        return {"error": "Please enter a name that doesn't exist in the platform."}, 409

    if len(json["name"]) > 150:
        return {"error": "The name you entered for the art item is too long."}, 400

    json["creator_artist"] = current_user.id

    creation_date = datetime.now()
    json["creation_date"] = creation_date

    art_item = create_art_item_record(json)

    db.session.add(art_item)
    db.session.commit()

    return {"id": art_item.id}, 201


# Function that makes the external API call. Finds the dominant colors for a given image URL.
# Returns an empty list if there is an error with the API call.


def get_dominant_colors(image_url):

    color_names = []

    endpoint_url = "https://api.imagga.com/v2/colors"

    basic_auth = (COLOR_FINDER_API_KEY, COLOR_FINDER_API_SECRET)

    querystring = {"image_url": image_url,
                   "extract_object_colors": 0
                   }

    response = requests.request(
        "GET", endpoint_url, auth=basic_auth, params=querystring)

    if 200 <= response.status_code < 300:  # external API call is successful

        json = response.json()
        image_colors = json['result']['colors']['image_colors']

        for color in image_colors:
            name = color['closest_palette_color']
            color_names.append(name)

    return color_names


# UTILITY FUNCTIONS

def name_exists(title):
    art_item = ArtItem.query.filter_by(name=title).first()
    return art_item != None


def create_art_item_record(json):

    name = json["name"]
    description = json["description"]
    creator_artist = json["creator_artist"]
    content_uri = json["content_uri"]
    creation_date = json["creation_date"]

    new_art_item = ArtItem(
        name=name,
        description=description,
        creator_artist=creator_artist,
        content_uri=content_uri,
        creation_date=creation_date
    )

    return new_art_item
