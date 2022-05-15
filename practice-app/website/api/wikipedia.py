from flask import Blueprint, request
import json
import urllib.request

wikipedia = Blueprint("wikipedia", __name__)

# ROUTES

@wikipedia.route("/wikipedia_definition", methods=["POST"])
def wikipedia_definition():

    req_json = request.json

    if "word" not in req_json:
        return {"error": "You did not send any words."}, 400

    if req_json["word"] == "":
        return {"error": "You did not send any words."}, 400

    word = req_json["word"]

    wikipediaEndPoint = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exlimit=1&explaintext=1&exsectionformat=plain&format=json&origin=*&titles=" + word

    req = urllib.request.Request(wikipediaEndPoint, headers={'content-type': 'application/json'})
    res = json.loads(urllib.request.urlopen(req).read())
    pages = res["query"]["pages"]
    definition = pages[list(pages.keys())[0]]["extract"]

    return {"definition": definition}, 200
