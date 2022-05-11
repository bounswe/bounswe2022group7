from decimal import ExtendedContext
from flask import Blueprint, request

from ..models import Participants
from .. import db

participants = Blueprint("participants", __name__)

@participants.route("/participants/add", methods=["POST"])
def add_participant():

    if (request.is_json):
        body = request.get_json()

        try:
            request_event_id = body["event_id"]
            participant_list = body["participants"]
            for participant in participant_list:

                request_user_id = participant["user_id"]
                if Participants.query.filter_by(event_id=request_event_id, user_id=request_user_id).first():
                    return {"error": f"Participant with user id {request_user_id} is already added to the event given."}, 409

                new_participant = Participants(event_id = request_event_id, user_id=request_user_id)

                db.session.add(new_participant)

            db.session.commit()
            return {"success" : "Successfully added the participant"}, 201
        except:
            return {"error": "There was an error on key / value pairs on request body."}, 400
    else:
        return {"error": "Request body should be a JSON file."}, 400

        
@participants.route("/participants/remove", methods=["POST"])
def remove_participant():

    if (request.is_json):
        body = request.get_json()

        try:
            request_event_id = body["event_id"]
            participant_list = body["participants"]
            print(participant_list)
            for participant in participant_list:

                request_user_id = participant["user_id"]
                found_participant = Participants.query.filter_by(event_id=request_event_id, user_id=request_user_id).first()
                if not found_participant:
                    return {"error": f"User with id {request_user_id} does not participate in the event."}, 409

                print(found_participant)
                db.session.remove(found_participant)

            db.session.commit()
            return {"success" : "Successfully added the participant"}, 201
        except Exception as e:
            print(e)
            return {"error": "There was an error on key / value pairs on request body."}, 400
    else:
        return {"error": "Request body should be a JSON file."}, 400

@participants.route("/participants", methods=["GET"])
def view_participants():

    try:
        request_event_id = request.args.get("event_id")
        participant_list = Participants.query.filter(Participants.event_id == request_event_id).all()

        if not participant_list:
            return {"error": f"No participant is found for event with the id {request_event_id}."}, 404    

        event_participants = [{"user_id": item.user_id} for item in participant_list]
        response = {"participants": event_participants}

        return response, 201
    except:
        return {"error": "Invalid arguments"}, 400

