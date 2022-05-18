from flask import Blueprint, jsonify, request
from time import time
from flask_jwt_extended import current_user, jwt_required
import datetime

from .jwt import user_required
from ..models import verificationRequest, User
from .. import db


status_conversion = {1: "Approved", 0: "Pending", -1:"Rejected"}

verify = Blueprint("verification", __name__)


@verify.route("/verification/<request_id>", methods=["GET"])
# @jwt_required()
def get_verification_request_data(request_id):

	global status_conversion

	req = verificationRequest.query.get(request_id)
	print("get method")
	if not req:
		return {"error": f"There are no requests with the id {request_id}."}, 404    

	req = req.serialize()
	print(req)
	req["user_name"]  = User.query.get(req["user_id"]).get_name()
	req["request_date"] = datetime.datetime.fromtimestamp(req["request_date"])
	req["status"] = status_conversion[req["status"]]

	return req, 200

@verify.route("/verification/request", methods=["POST"])
@jwt_required()
def requestVerification():

	req = verificationRequest.query.filter(
			verificationRequest.status==0, 
			verificationRequest.user_id==current_user.id
			).first()

	if req is None:
		new_request = verificationRequest(
			user_id=current_user.id,
			request_date=time(),
			status=0)

		print("user_id new request:", new_request.user_id)
		print("current_user:", current_user.id)
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

	print("begin")
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