#####
# This file implements API endpoints for participant feature for events
# @author: erimerkin
#####

from flask import Blueprint, request

from ..models import Participants, User
from .. import db

participants = Blueprint("participants", __name__)


# API endpoint for adding participants to an event
@participants.route("/participants", methods=["POST"])
def add_participant():

    # Checks if the request body is JSON, otherwise returns error message
    if (request.is_json):
        body = request.get_json()

        # Tries to handle key/value errors 
        try:
            # parses the values for keys
            request_event_id = body["event_id"]
            participant_list = body["participants"]
        except:
            return {"error": "There was an error on key / value pairs on request body."}, 400

        # Iterates over every participant in the JSON to add them to event
        for participant in participant_list:
            
            # reads the user id
            try:
                request_user_id = participant["user_id"]
            except:
                return {"error": "There was an error on key / value pairs on request body."}, 400

            # Check if the user exists
            # if not User.query.filter_by(id=request_user_id).first():
            #     return {"error": f"User with id {request_user_id} doesn't exist."}, 409


            # Checks if the participant is already added to event
            if Participants.query.filter_by(event_id=request_event_id, user_id=request_user_id).first():
                return {"error": f"Participant with user id {request_user_id} is already added to the event given."}, 409

            new_participant = Participants(event_id = request_event_id, user_id=request_user_id)

            # Tries to add the new participant
            try:
                db.session.add(new_participant)
            except:
                return {"error" : f"There was an error adding the user with id {request_user_id} as a participant to event."}, 500

        # Handles DB commit
        try:
            db.session.commit()
        except Exception as error:
            return {"error" : f"Database commit error: {error}"}, 500

        # Success message
        return {"success" : "Successfully added the participant"}, 201
    
    else:
        return {"error": "Request body should be a JSON file."}, 400

# API endpoint for removing participants from an event
@participants.route("/participants", methods=["DELETE"])
def remove_participant():

    # Checks if the request body is json
    if (request.is_json):
        body = request.get_json()

        try:
            request_event_id = body["event_id"]
            participant_list = body["participants"]
        except:
            return {"error": "There was an error on key / value pairs on request body."}, 400

        # Iterates over participants given in the JSON
        for participant in participant_list:

            try:
                request_user_id = participant["user_id"]
            except:
                return {"error": "There was an error on key / value pairs on request body."}, 400

            found_user = db.session.query(Participants).filter(Participants.event_id==request_event_id, Participants.user_id == request_user_id).first()
            if (found_user):
                try:
                    db.session.delete(found_user)
                except:
                    return {"error" : f"There was an error removing the user with id {request_user_id} from event."}, 500
            else:
                return {"error": f"User with id {request_user_id} does not participate in the event."}, 409

        # Handles exceptions for db commit
        try:
            db.session.commit()
        except Exception as error:
            return {"error" : f"Database error when commiting: {error}"}, 500                

        return {"success" : "Successfully removed the participant"}, 200
        

    
    else:
        return {"error": "Request body should be a JSON file."}, 400


# API endpoint for listing all participants for an event
@participants.route("/participants", methods=["GET"])
def view_participants():

    # Tries to parse request arguments
    try:
        request_event_id = request.args.get("event_id")
    except:
        return {"error": "Invalid arguments"}, 400

    participant_list = Participants.query.filter(Participants.event_id == request_event_id).all()

    # Returns error if there is no participant?
    # if not participant_list:
    #     return {"error": f"No participant is found for event with the id {request_event_id}."}, 404    

    event_participants = [{"user_id": item.user_id} for item in participant_list]
    response = {"participants": event_participants}

    return response, 200


