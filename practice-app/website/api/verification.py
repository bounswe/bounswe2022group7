from flask import Blueprint, jsonify, request
from time import time
from flask_jwt_extended import current_user, jwt_required
import datetime
import requests
from random import randint

from .jwt import user_required
from ..models import verificationRequest, User
from .. import db


status_conversion = {1: "Approved", 0: "Pending", -1:"Rejected"}

verify = Blueprint("verification", __name__)


@verify.route("/verification/<request_id>", methods=["GET"])
def get_verification_request_data(request_id):

	global status_conversion

	req = verificationRequest.query.get(request_id)
	if not req:
		return {"error": f"There are no requests with the id {request_id}."}, 404    

	req = req.serialize()
	req["user_name"]  = User.query.get(req["user_id"]).get_name()
	req["request_date"] = datetime.datetime.fromtimestamp(req["request_date"])

	historical_event, year = getHistoricalEvent(req["request_date"])
	req["historical_event"] = historical_event
	req["year"] = year

	req["status"] = status_conversion[req["status"]]

	return req, 200


@verify.route("/verification/request", methods=["POST"])
@jwt_required()
def requestVerification():

	# req = verificationRequest.query.filter(
	# 		verificationRequest.status==0, 
	# 		verificationRequest.user_id==current_user.id
	# 		).first()

	pending = hasPendingRequest(current_user.id)

	if not pending:

		is_verified = isVerified(current_user.id)

		if is_verified:
			return jsonify(message="You are a verified user!"), 409

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
@jwt_required()
def reviewVerificationRequest(request_id):

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
	  'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI4YWFiNTE0ZmY2Yjk1ZDY4MDBkZWZjOTBmNzNkMWZlYyIsImp0aSI6Ijk5YTY0NmQzODIwYzUzZmVhZDIxZTUyZjlmN2Y2NzM3YmYxN2NhYTNjYTcyNWJhZjRiZDFkY2FlMjE0NjE5MjJjNjBhYWY2MTIwY2Q1MGYwIiwiaWF0IjoxNjUyOTIyNzI5LCJuYmYiOjE2NTI5MjI3MjksImV4cCI6MzMyMDk4MzE1MjksInN1YiI6IjY5NzI0MTEyIiwiaXNzIjoiaHR0cHM6XC9cL21ldGEud2lraW1lZGlhLm9yZyIsInJhdGVsaW1pdCI6eyJyZXF1ZXN0c19wZXJfdW5pdCI6NTAwMCwidW5pdCI6IkhPVVIifSwic2NvcGVzIjpbImJhc2ljIl19.PCPnfTQVPmMh1dw0pV2dfxplSQk8D7S2EuUbCTxOuCaz3-FUw_wvYl3jXLzrxG3KAZHiGgiUp-f-gbwAhxhoMwaYU2NJQWYtY71l6Clo8DDwYC5JgiftfQKW_ngqfMyZ0MOTo71frN5aaU7jfQL2iZ5MlR2cHR1ri-hAoN7Md3bkn-H2n-3VnbW3UqMY0lC187vUc2FePfXLv-RYEfby-YeiuWOCc5ISZ4lL7lwc0jATcbyoVX27DVORx0UQdDeWq3ytTHCo5WOfvbH2hsTviL0TZ-DV2CJIquFxn2PfG04jJKgY5mPicMXIaPCMJq05-aHWmc3ikkq-a9lSSVnk1VOJTDd7vNZRDMtojTx0KnogYrkt7ZGY4QlXkVygVGYqnWHrM-yC7NHvznxeV07KY-qBCQa1oI7RlVGcVUlCPdnUYvUqJR8mMLMijOPioIRHiUvQEFBZuwRi76MiQ75hJhJJwfv3gCAQbRPqTKUXz_uDSL1eX9BHOZFSx9DrOEh9c0f44Lel02W6UVw_bpdYHrtZ3GVEEtibQ3wpP5zNfwDIrCF4pg459g6Z3pvV2Ahq1tpbY0U7FDGbYXD8iMG8GXMOUgSzEJ8nALoU6kJMgZZfpYwc0GJNw851mCHiBmq1_IaWENsUDpe-Atz4SC6KZsGJuhoLy6PNwr5EMc4-X-4',
	  'User-Agent': 'ArtShare'
	}

	response = requests.get(url, headers=headers)
	data = response.json()


	rn = randint(0, len(data["selected"]))
	return data["selected"][rn]["text"], data["selected"][rn]["year"]