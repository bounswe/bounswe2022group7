#####
# This file implements API endpoints for participant feature for events
# @author: erimerkin
#####

import urllib
import requests
from datetime import datetime

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

    """
    file: ./doc/participants_POST.yml
    """


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

    
# API endpoint for removing participants from an event
@participants.route("/participants/<event_id>", methods=["DELETE"])
@user_required()
def remove_participant(event_id):


    """
    file: ./doc/participants_DELETE.yml
    """

    # Checks if event is valid
    event = Event.query.get(event_id)
    if not event:
        return {"error": f"There are no events with the id {event_id}."}, 404 
 
    # For event creator to remove participants from event
    if (request.is_json):
        body = request.get_json()   

        # Check if the current user is owner of the event
        if (current_user.id == event.artist_id):
            try:
                participant_list = body["participants"]
            except:
                return {"error": "There was an error on key / value pairs on request body."}, 400

            # Iterates over participants given in the JSON

            # Even if only one user is not part of a 100 item list, all of the removal process will be halted since
            # that user is not a participant
            for participant_id in participant_list:

                found_user = db.session.query(Participants).filter(Participants.event_id==event_id, Participants.user_id == participant_id).first()
                if (found_user):
                    try:
                        db.session.delete(found_user)
                    except:
                        return {"error" : f"There was an error removing the user with id {participant_id} from event."}, 500
                else:
                    return {"error": f"User with id {participant_id} does not participate in the event."}, 409
            
            # Handles exceptions for db commit
            try:
                db.session.commit()
            except Exception as error:
                return {"error" : f"Database error when commiting: {error}"}, 500                

            return {"success" : "Successfully removed the participant(s)."}, 200

        else:
            return {"error" : "User is not the creator of the event"}, 403

    else: # For user's own removal from event

        # Query the user from jwt token
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
            return {"error": f"User with id {current_user.id} does not participate in the event."}, 409
   

# API endpoint for listing all participants for an event
@participants.route("/participants/<event_id>", methods=["GET"])
@user_required()
def view_participants(event_id):


    """
    file: ./doc/participants_GET.yml
    """

    event = Event.query.get(event_id);
    if not event:
        return {"error": f"There are no events with the id {event_id}."}, 404    

    participant_list = Participants.query.filter(Participants.event_id == event_id).all()

    event_participants = []
    participating = False
    for item in participant_list:

        if (item.user_id == current_user.id and not(participating)):
            participating = True

        participant = User.query.get(item.user_id)
        event_participants.append({"user_id": item.user_id, "user_name" : participant.first_name + " " + participant.last_name})
    
    is_creator = (event.artist_id == current_user.id)

    return {"event_title": event.title, "is_creator": is_creator, "user_participating" : participating, "participants": event_participants}, 200


# this creates share link by making an external api call
@participants.route("/participants/share/<event_id>", methods=["POST"])
@user_required()
def get_share_link(event_id):


    """
    file: ./doc/participants_share_POST.yml
    """

    if not Event.query.get(event_id):
        return {"error": f"There are no events with the id {event_id}."}, 404   

    if (request.is_json):
        body = request.get_json()

        # Tries to handle key/value errors 
        try:
            target_url = body["page_url"]
        except:
            return {"error": "There was an error on key / value pairs on request body."}, 400

        shortened_url = create_personal_share_link(target_url, event_id, current_user.id)
        
        if shortened_url["status"] == 200:
            return {"share_link": shortened_url["link"]}, 201
        else:
            return {"error" : shortened_url["message"]}, shortened_url["status"]
    else:
        return {"error": "Request body should be a JSON file."}, 400
        

# Makes API call to URL shortener
from ..settings import SHORTENER_API_KEY
def create_personal_share_link(page_url, event_id, user_id, link_prefix='bounswe2022g7', recursion=0):

    if recursion != 3:

        # Encodes URL, calculates timestamp for share link
        target_url = urllib.parse.quote(f'{page_url}', safe='')
        curr_time = datetime.now()
        link_name  = f'{link_prefix}-e{event_id}-u{user_id}-{int(datetime.timestamp(curr_time))}'

        response = requests.get(f'http://cutt.ly/api/api.php?key={SHORTENER_API_KEY}&short={target_url}&name={link_name}')
        
        if response.status_code == 200:

            response_body = response.json()["url"]
            response_status = response_body["status"]

            # Link is created
            if (response_status == 7):
                shortened_link = response_body["shortLink"]
                return {"status" : 200, "link": shortened_link}

            # Link is from a blocked domain
            elif (response_status == 6):
                return {"status": 409, "message" :"The link provided is from a blocked domain"}

            # Invalid link
            elif (response_status == 5):
                return {"status" : 400, "message" : "Invalid link"}

            # Invalid API key
            elif (response_status == 4):
                return {"status": 400, "message":"Invalid API key"}
            
            # link name already taken, try again with another name
            elif (response_status == 3):
                return create_personal_share_link(page_url, event_id, user_id, link_prefix=f'{link_prefix}', recursion=recursion+1)
    
            # Invalid link
            elif (response_status == 2):
                return {"status": 400, "message" : "Not a link"}

            # Link is already shortened
            elif (response_status == 1):
                return {"status": 409, "message" : "The link is already shortened"}
            
            else:
                return {"status": 502, "message" : "Unexpected Error"}
        
        else: # Outside of API definition
            return {"status": 500, "message" : "Error when creating the share link. Try again later."}
    
    else:
        return {"status": 500, "message" :"Couldn't create the link. Try again later"}




        

