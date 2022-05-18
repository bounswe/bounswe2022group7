import unittest

from .. import create_app, db
from ..models import Event, Participants

from ..api.event import title_exists, date_valid
from ..api.participants import *

TEST_DB_NAME = "test_database.db"


class TestEvent(unittest.TestCase):

    def setUp(self):

        app = create_app(TEST_DB_NAME)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        # MOCK EVENT AND USER DATA
        self.artist_data = {
            "email": "artist@mail.com",
            "password": "pass",
            "first_name": "ArtistName",
            "last_name": "Test",
            "is_artist": "on"
        }

        # MOCK EVENT AND USER DATA
        self.artist_data2 = {
            "email": "artist@mail.com",
            "password": "pass",
            "first_name": "ArtistName",
            "last_name": "Test",
            "is_artist": "on"
        }

        self.user_data = {
            "email": "user@mail.com",
            "password": "pass",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": None
        }

        response = self.client.post("/api/signup",
                                    json=self.artist_data,
                                    content_type = "application/json; charset=UTF-8")
        self.artist_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        response = self.client.post("/api/signup",
                                    json=self.artist_data2,
                                    content_type = "application/json; charset=UTF-8")
        self.artist2_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type = "application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        event1 = Event(title = "test", description = "test", poster_link = "none",date = 1111-11-11, city = "Istanbul",  artist_id = 1)
        event2 = Event(title = "test2", description = "test2", poster_link = "none",date = 1111-11-11, city = "Istanbul",  artist_id = 2)

        db.session.add(event1)
        db.session.add(event2)
        db.session.commit()

    def add_participant_request(self, id, auth):
        return self.client.post(f"/api/participants/{id}",
                                headers = {"Authorization": "Bearer %s" % auth})
    
    def remove_participant_request(self, id, auth):
        return self.client.delete(f"/api/participants/{id}",
                                headers = {"Authorization": "Bearer %s" % auth})

    def view_participants_request(self, id):
        return self.client.get(f"/api/participants/{id}")

    def test_add_participant_invalid_requests(self):

        # invalid path
        response = self.add_participant_request(self, "", self.artist_access_token)

        self.assertEqual(response.status, "400 BAD REQUEST")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], "Wrong path please use /api/participants/<event_id>")


        # invalid event id
        invalid_id_response = self.add_participant_request(self, 99, self.artist_access_token)

        self.assertEqual(invalid_id_response.status, "404 NOT FOUND")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], f"There are no events with the id 99.")

    def test_add_participant_auth(self):
        response = self.add_participant_request(self, 1, self.user_access_token + "23")
        self.assertEqual(response.status, "403 FORBIDDEN")

    def test_add_participant_valid(self):
        response = self.add_participant_request(self, 1, self.user_access_token)
        self.assertEqual(response.status, "201 CREATED")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], "Successfully added the participant")

    def test_add_participant_duplicate(self):
        response = self.add_participant_request(self, 1, self.user_access_token)
        self.assertEqual(response.status, "201 CREATED")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], "Successfully added the participant")

    
    # test view participants
        # invalid url
        # invalid event
        # empty part list
        # valid
            # user participating
            # user not part

    # test remove participants
        # unauth
        # invalid url
        # invalid event
        # not participating in event
        # valid removal

    # sharing test
        # invalid body
            # invalid path
            # invalid domain
        # unauth
        # invalid event id





    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()