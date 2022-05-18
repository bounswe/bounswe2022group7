#####
# This file implements API endpoints for participant feature for events
# @author: erimerkin
#####

import urllib
import requests

from flask import Blueprint, request
from flask_jwt_extended import current_user

from ..models import Participants, User, Event
from .jwt import user_required
from .. import db

participants = Blueprint("participants", __name__)


# API endpoint for adding participants to an event
@participants.route("/participants/<event_id>", methods=["POST"])
@user_required()
def add_participant(event_id):

    if (event_id):
        if not Event.query.get(event_id):
            return {"error": f"There are no events with the id {event_id}."}, 404    

        # Checks if the participant is already added to event
        if Participants.query.filter_by(event_id=event_id, user_id=current_user.id).first():
            return {"error": f"User with id {current_user.id} is already participating in this event."}, 409

        new_participant = Participants(event_id = event_id, user_id=current_user.id)

        # Tries to add the new participant
        try:
            db.session.add(new_participant)
        except:
            return {"error" : f"There was an error adding the user with id {current_user.id} as a participant to event."}, 500

        # Handles DB commit
        try:
            db.session.commit()
        except Exception as error:
            return {"error" : f"Database commit error: {error}"}, 500

        # Success message
        return {"success" : "Successfully added the participant"}, 201
    else:
        return {"error" : "Wrong path please use /api/participants/<event_id>"}, 400
    


# API endpoint for removing participants from an event
@participants.route("/participants/<event_id>", methods=["DELETE"])
@user_required()
def remove_participant(event_id):
    if (event_id):
        # Checks if the request body is json
        if (request.is_json):
            body = request.get_json()

            event = Event.query.get(event_id)
            if not event:
                return {"error": f"There are no events with the id {event_id}."}, 404    

            if (current_user.id == event.artist_id):
                try:
                    participant_list = body["participants"]
                except:
                    return {"error": "There was an error on key / value pairs on request body."}, 400

                # Iterates over participants given in the JSON
                for participant in participant_list:

                    try:
                        request_user_id = participant["user_id"]
                    except:
                        return {"error": "There was an error on key / value pairs on request body."}, 400

                    found_user = db.session.query(Participants).filter(Participants.event_id==event_id, Participants.user_id == request_user_id).first()
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

                return {"success" : "Successfully removed the participant(s)."}, 200

            else:
                return {"error" : "User is not the creator of the event"}, 400

        else:
            found_user = db.session.query(Participants).filter(Participants.event_id==event_id, Participants.user_id == current_user.id).first()
            if (found_user):
                try:
                    db.session.delete(found_user)
                except:
                    return {"error" : f"There was an error removing the user with id {current_user.id} from event."}, 500

                #  Handles exceptions for db commit
                try:
                    db.session.commit()
                except Exception as error:
                    return {"error" : f"Database error when commiting: {error}"}, 500                

                return {"success" : "Successfully removed the participant(s)."}, 200

                
            else:
                    return {"error": f"User with id {request_user_id} does not participate in the event."}, 409
    else:
        return {"error" : "You didn't specify the event. Please, use this endpoint as /api/participants/<event_id>"}, 400


# API endpoint for listing all participants for an event
@participants.route("/participants/<event_id>", methods=["GET"])
def view_participants(event_id):

    if (event_id):

        if not Event.query.get(event_id):
            return {"error": f"There are no events with the id {event_id}."}, 404    

        participant_list = Participants.query.filter(Participants.event_id == event_id).all()

        event_participants = []
        for item in participant_list:
            participant = User.query.get(item.user_id)
            event_participants.append({"user_id": item.user_id, "user_name" : participant.first_name + " " + participant.last_name})
        response = {"participants": event_participants}

        return response, 200
    
    else:
        return {"error" : "You didn't specify the event. Please, use this endpoint as /api/participants/<event_id>"}, 400

@participants.route("/participants/get_info/<event_id>", methods=["GET"])
@user_required()
def get_participation_info(event_id):

    if (event_id):

        event = Event.query.get(event_id)
        if not event:
            return {"error": f"There are no events with the id {event_id}."}, 404   


        # Tries to handle key/value errors 

        participant_list = Participants.query.filter(Participants.event_id == event_id).all()


        participating = False
        if (current_user):
            for participant in participant_list:
                if (participant.user_id == current_user.id):
                    participating = True
                    break
    
        is_creator = (event.artist_id == current_user.id)

        return {"event_title": event.title, "is_creator": is_creator,"user_participating" : participating}, 200

        
    else:
        return {"error" : "You didn't specify the event. Please, use this endpoint as /api/participants/get_info/<event_id>"}, 400

@participants.route("/participants/share/<event_id>", methods=["POST"])
@user_required()
def create_share_link(event_id):

    if (event_id):

        if not Event.query.get(event_id):
            return {"error": f"There are no events with the id {event_id}."}, 404   

        if (request.is_json):
            body = request.get_json()

            # Tries to handle key/value errors 
            try:
                # parses the values for keys
                target_domain = body["domain"]
                target_path = body["path"]
            except:
                return {"error": "There was an error on key / value pairs on request body."}, 400


            shortened_url = create_unique_sharing_link(target_domain, target_path, event_id, current_user.id)
            
        
            if (shortened_url["status"] == "success"):
                return {"share_link": shortened_url["link"]}, 200
            else:
                return shortened_url, 500
        else:
            return {"error": "Request body should be a JSON file."}, 400
        
    else:
        return {"error" : "You didn't specify the event. Please, use this endpoint as /api/participants/get_info/<event_id>"}, 400


from ..settings import SHORTENER_API_KEY
def create_unique_sharing_link(domain, path, event_id, user_id, link_prefix='bounswe2022g7', recursion=0):

    if recursion != 3:
        target_url = urllib.parse.quote(f'{domain}{path}', safe='')
        link_name  = f'{link_prefix}-e{event_id}-u-{user_id}'
        print(target_url)


        response = requests.get(f'http://cutt.ly/api/api.php?key={SHORTENER_API_KEY}&short={target_url}&name={link_name}')
        
        if response.status_code == 200:
            response_body = response.json()["url"]
            response_status = response_body["status"]
            # Link is created
            if (response_status == 7):
                shortened_link = response_body["shortLink"]
                return {"status" : "success", "link": shortened_link}
            # Link is from a blocked domain
            elif (response_status == 6):
                return {"status" : "error", "message":"The link provided is from a blocked domain"}

            # Invalid link
            elif (response_status == 5):
                return {"status" : "error", "message":"Invalid link"}

            # Invalid API key
            elif (response_status == 4):
                return {"status" : "error", "message":"Invalid API key"}
            # link name already taken, try again with another name
            elif (response_status == 3):
                print("TEst")
                return create_unique_sharing_link(domain, path, event_id, user_id, link_prefix=f'{link_prefix}-a', recursion=recursion+1)
    
            elif (response_status == 2):
                return {"status" : "error", "message":"Not a link"}

            # Link is already shortened
            elif (response_status == 1):
                return {"status" : "error", "message":"The link is already shortened"}
            else:
                return {"status" : "error", "message":"Unexpected Error"}
        else:
            return {"status" : "error", "message":"Unexpected Error"}
    else:
        return {"status" : "error", "message":"Couldn't create the link"}




        

