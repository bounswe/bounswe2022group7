import unittest

from .. import create_app, db
from ..models import verificationRequest

from ..api.verification import isVerified, hasPendingRequest

TEST_DB_NAME = "test_database.db"

class TestVerification(unittest.TestCase):

	def setUp(self):

		app = create_app(TEST_DB_NAME)
		self.ctx = app.app_context()
		self.ctx.push()
		self.client = app.test_client()


		self.user_data = {
			"email": "user@example.boun.edu.tr",
			"password": "1234",
			"first_name": "User",
			"last_name": "Test",
			"is_artist": None
		}

		self.user_data2 = {
			"email": "user@example.boun.edu",
			"password": "1234",
			"first_name": "User",
			"last_name": "Test",
			"is_artist": None
		}

		self.user_data3 = {
			"email": "user@example.boun",
			"password": "1234",
			"first_name": "User",
			"last_name": "Test",
			"is_artist": None
		}

		self.user_data4 = {
			"email": "user@example",
			"password": "1234",
			"first_name": "User",
			"last_name": "Test",
			"is_artist": None
		}

		self.user_data5 = {
			"email": "user5@example.boun.edu.tr",
			"password": "1234",
			"first_name": "User",
			"last_name": "Test",
			"is_artist": None
		}


		response_user_signup = self.client.post("/api/signup",
		                            json=self.user_data,
		                            content_type = "application/json; charset=UTF-8")
		self.user_access_token = response_user_signup.json.get("access_token")
		self.assertEqual(response_user_signup.status, "201 CREATED")

		response_user_signup = self.client.post("/api/signup",
		                            json=self.user_data2,
		                            content_type = "application/json; charset=UTF-8")
		self.user_access_token2 = response_user_signup.json.get("access_token")
		self.assertEqual(response_user_signup.status, "201 CREATED")

		response_user_signup = self.client.post("/api/signup",
		                            json=self.user_data3,
		                            content_type = "application/json; charset=UTF-8")
		self.user_access_token3 = response_user_signup.json.get("access_token")
		self.assertEqual(response_user_signup.status, "201 CREATED")

		response_user_signup = self.client.post("/api/signup",
		                            json=self.user_data4,
		                            content_type = "application/json; charset=UTF-8")
		self.user_access_token4 = response_user_signup.json.get("access_token")
		self.assertEqual(response_user_signup.status, "201 CREATED")

		response_user_signup = self.client.post("/api/signup",
		                            json=self.user_data5,
		                            content_type = "application/json; charset=UTF-8")
		self.user_access_token5 = response_user_signup.json.get("access_token")
		self.assertEqual(response_user_signup.status, "201 CREATED")



	def makeVerificationRequest(self, access_token):
		response2 = self.client.post("/api/verification/request",
								content_type="application/json; charset=UTF-8",
								headers= {"Authorization": "Bearer %s" % access_token}
								)

		self.assertIn('201', response2.status)
		return response2



	def verifyUser(self, access_token, request_id):
		response2 = self.client.post("/api/verification/review/%s" % request_id,
								json= {"result": "accept"},
								content_type="application/json; charset=UTF-8",
								headers= {"Authorization": "Bearer %s" % access_token}
								)
		return response2


	def testRequestVerificationSuccessful(self):
		response2 = self.makeVerificationRequest(self.user_access_token)
		self.request_id = response2.json.get("id")

		self.assertIn('201', response2.status)



	def testRequestVerificationPending(self):
		self.makeVerificationRequest(self.user_access_token2)

		response2 = self.client.post("/api/verification/request",
								content_type="application/json; charset=UTF-8",
								headers= {"Authorization": "Bearer %s" % self.user_access_token2}
								)
		self.assertIn('You already have a pending request!', response2.json.get('message'))



	def testRejectUser(self):
		response = self.makeVerificationRequest(self.user_access_token3)
		print(response.json)
		self.request_id3 = response.json.get('id')
		
		response2 = self.client.post("/api/verification/review/%s" % self.request_id3,
    							json= {"result": "reject"},
    							content_type="application/json; charset=UTF-8",
    							headers= {"Authorization": "Bearer %s" % self.user_access_token3}
    							)

		self.assertIn('201', response2.status)



	def testVerifyUser(self):
		response = self.makeVerificationRequest(self.user_access_token4)
		self.request_id4 = response.json.get("id")
		
		response = self.verifyUser(self.user_access_token4, self.request_id4)
		self.assertIn('201', response.status)



	def testVerifiedUser(self):
		response = self.makeVerificationRequest(self.user_access_token5)
		self.request_id5 = response.json.get("id")

		response = self.verifyUser(self.user_access_token5, self.request_id5)

		response2 = self.client.post("/api/verification/request",
								content_type="application/json; charset=UTF-8",
								headers= {"Authorization": "Bearer %s" % self.user_access_token5}
								)

		self.assertIn('You are a verified user!', response2.json.get("message"))



	def tearDown(self):
		db.drop_all()
		self.ctx.pop() 


if __name__ == "__main__":
	unittest.main()