from flask import Blueprint, jsonify, request
from time import time
from flask_jwt_extended import current_user, jwt_required
import datetime
import requests
from random import randint
from ..settings import ON_THIS_DAY_API_KEY

from .jwt import user_required
from ..models import verificationRequest, User
from .. import db



status_conversion = {1: "Approved", 0: "Pending", -1:"Rejected"}

verify = Blueprint("verification", __name__)


@verify.route("/verification/<request_id>", methods=["GET"])
def get_verification_request_data(request_id):
	"""
	file: ./doc/verification_request_GET.yml
	"""

	global status_conversion

	req = verificationRequest.query.get(request_id)
	if not req:
		return {"error": f"There are no requests with the id {request_id}."}, 404    

	req = req.serialize()
	req["user_name"]  = User.query.get(req["user_id"]).get_name()

	historical_event, year = getHistoricalEvent(datetime.datetime.fromtimestamp(req["request_date"]))
	req["request_date"] = str(datetime.datetime.fromtimestamp(req["request_date"]))
	req["historical_event"] = historical_event
	req["year"] = year

	req["status"] = status_conversion[req["status"]]

	return req, 200


@verify.route("/verification/request", methods=["POST"])
@user_required()
def requestVerification():

	"""
	file: ./doc/request_verification_POST.yml
	"""

	pending = hasPendingRequest(current_user.id)

	if not pending:

		is_verified = isVerified(current_user.id)

		if is_verified:
			return jsonify(message="You are a verified user!"), 408

		new_request = verificationRequest(
			user_id=current_user.id,
			request_date=time(),
			status=0)

		try:
			db.session.add(new_request)
			db.session.commit()

			return jsonify(id=new_request.id), 201
		except:
			return jsonify(message="An error occured, please try again later"), 500


	else:
		return jsonify(message="You already have a pending request!"), 409



@verify.route("/verification/review/<request_id>", methods=["POST"])
@user_required()
def reviewVerificationRequest(request_id):

	"""
	file: ./doc/review_verification_request_POST.yml
	"""

	result = request.json.get("result", None)

	req = verificationRequest.query.filter(
		verificationRequest.status==0,
		verificationRequest.id==request_id
		).first()

	if req is not None:
		req.status = (result=="reject")*(-2) + 1

		try:
			db.session.add(req)
			db.session.commit()

			return jsonify(status=req.status, id=request_id), 201

		except:
			return jsonify(message="An error occured, please try again later."), 500
	else:
		return jsonify(message="There is no available request with this id!"), 409



### METHODS

def isVerified(user_id):
	req = verificationRequest.query.filter(
			verificationRequest.status==1, 
			verificationRequest.user_id==user_id
			).first()

	if req is None:
		return False
	else:
		return True


def hasPendingRequest(user_id):
	req = verificationRequest.query.filter(
			verificationRequest.status==0, 
			verificationRequest.user_id==user_id
			).first()

	if req is not None:
		return True
	else:
		return False


def getHistoricalEvent(request_date):
	date = request_date.strftime('%m/%d')

	url = 'https://api.wikimedia.org/feed/v1/wikipedia/en/onthisday/selected/' + date

	headers = {
	  'Authorization': ON_THIS_DAY_API_KEY,
	  'User-Agent': 'ArtShare'
	}

	response = requests.get(url, headers=headers)
	data = response.json()


	rn = randint(0, len(data["selected"]))
	return data["selected"][rn]["text"], data["selected"][rn]["year"]