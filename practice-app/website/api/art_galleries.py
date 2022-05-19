import requests
from flask import Blueprint, request, jsonify


art_galleries = Blueprint('art_galleries', __name__)


@art_galleries.route('art_galleries')
def get_art_galleries():
    """
    file: ./doc/art_galleries.yml
    """
    galleries = []

    for i in range(5):
        data = requests.get(
            'https://random-data-api.com/api/address/random_address'
        ).json()
        gallery = {
            'address': data['full_address'],
            'name': data['city'] + ' Art Gallery',
        }
        galleries.append(gallery)

    return jsonify(galleries)
