import unittest

from .. import create_app, db

from ..api.profile import *

class TestProfile(unittest.TestCase):

    def setUp(self):
        
        app = create_app(testing=True)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        self.user_data = {
            "email": "user@mail.com",
            "password": "pass",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": None
        }

        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type = "application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

    def test_profile(self):
        response = self.client.get("/api/profile/",
                                content_type="application/json; charset=UTF-8",
                                headers = {"Authorization": "Bearer %s" % self.user_access_token})
        self.assertEqual(response.status, "200 OK")
        data = response.json
        self.assertEqual(data["email"], self.user_data["email"])
        self.assertEqual(data["first_name"], self.user_data["first_name"])
        self.assertEqual(data["last_name"], self.user_data["last_name"])

    def test_profile_without_auth_header(self):
        response = self.client.get("/api/profile/")
        self.assertEqual(response.status, "401 UNAUTHORIZED")

    def tearDown(self):
        db.drop_all()
        self.ctx.pop()
