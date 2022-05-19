import requests
from ..settings import WEATHER_API_KEY
from flask import Blueprint, request
from flask_jwt_extended import current_user
from datetime import datetime

from ..models import Event, User
from .. import db

from .jwt import artist_required

event = Blueprint("event", __name__)

# ROUTES


@event.route("/event/<event_id>", methods=["GET"])
def get_event_data(event_id):
    """
    file: ./doc/event_GET.yml
    """

    event = Event.query.get(event_id)

    if not event:
        return {"error": f"There are no events with the id {event_id}."}, 404

    event = event.serialize()
    event["artist_name"] = User.query.get(event["artist_id"]).get_name()
    event["weather"] = get_weather_data(event["city"])

    return event, 200


@event.route("/event", methods=["POST"])
@artist_required()
def create_event():
    """
    file: ./doc/event_POST.yml
    """

    json = request.json

    missing_fields = {"title", "description", "poster_link",
                      "date", "city"} - set(request.json.keys())
    if len(missing_fields) > 0:
        return {"error": f"You have not provided some of the required fields. You are missing: " + str(missing_fields)}, 400

    if title_exists(json["title"]):
        return {"error": "Please enter a title that doesn't exist in the platform."}, 409

    if not date_valid(json["date"]):
        return {"error": f"Date you have entered is not valid. Format is \"%Y-%m-%d\". You entered \"{json['date']}\"."}, 400

    json["artist_id"] = current_user.id
    event = create_event_record(json)

    db.session.add(event)
    db.session.commit()

    return {"id": event.id}, 201


# METHODS


def get_weather_data(city):
    response = requests.get(url="https://api.openweathermap.org/data/2.5/weather",
                            params={
                                "appid": WEATHER_API_KEY,
                                "q": city
                            })

    weather_response = {}

    # For different API responses of the
    # external api, see:
    # https://openweathermap.org/faq

    if response.status_code == 200:
        weather_data = response.json()
        weather_response["temp"] = "%.2f C" % (
            weather_data["main"]["temp"] - 273)  # convert Kelvin to Celcius
        weather_response["weather"] = weather_data["weather"][0]["main"]
        return weather_response

    # API Key Rejected
    elif response.status_code == 401:
        weather_response["error"] = "API Key is not accepted. Can't display weather. Please contact the creators of the app and inform them."
    # City name not recognized
    elif response.status_code == 404:
        weather_response["error"] = "City name is not recognized by the external weather API. Can't display weather."
    # API Limit exceeded
    elif response.status_code == 429:
        weather_response["error"] = "Weather API limit is exceeded. Can't display weather. Wait for a while and refresh the page."
    # Something went wrong in the External API
    else:
        weather_response["error"] = "Something went wrong in the external Weather API. Can't display weather."

    return weather_response


def is_missing_field(json):
    missing_fields = {"title", "description", "poster_link",
                      "date", "city"} - set(request.json.keys())
    return len(missing_fields) > 0


def title_exists(title):
    event = Event.query.filter_by(title=title).first()
    return event != None


def date_valid(date):
    try:
        datetime.strptime(date, "%Y-%m-%d")
        return True
    except:
        return False


def create_event_record(json):

    new_event = Event(
        title=json["title"],
        description=json["description"],
        poster_link=json["poster_link"],
        date=datetime.strptime(json["date"], "%Y-%m-%d"),
        city=json["city"],
        artist_id=json["artist_id"]
    )

    return new_event
