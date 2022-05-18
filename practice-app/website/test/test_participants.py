from datetime import datetime
import unittest

from .. import create_app, db
from ..models import Event, Participants, Artist, User
from werkzeug.security import generate_password_hash

from ..api.event import title_exists, date_valid
from ..api.participants import *

TEST_DB_NAME = "test_participant_database.db"


class TestEvent(unittest.TestCase):



    def setUp(self):

        app = create_app(TEST_DB_NAME)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        self.user = requests.get(
            'https://randomuser.me/api/'
        ).json()['results'][0]
        self.user = {
            'email': self.user['email'],
            'password': self.user['login']['password'],
            'first_name': self.user['name']['first'],
            'last_name': self.user['name']['last'],
            'is_artist': False
        }
        response = self.client.post(
            "/api/signup",
            json=self.user,
            content_type='application/json; charset=UTF-8'
        )
        self.user_access_token = response.json["access_token"]

        self.artist = requests.get(
            'https://randomuser.me/api/'
        ).json()['results'][0]
        self.artist = {
            'email': self.artist['email'],
            'password': self.artist['login']['password'],
            'first_name': self.artist['name']['first'],
            'last_name': self.artist['name']['last'],
            'is_artist': True
        }
        response = self.client.post(
            "/api/signup",
            json=self.artist,
            content_type='application/json; charset=UTF-8'
        )
        self.artist_access_token = response.json["access_token"]

        self.artist2 = requests.get(
            'https://randomuser.me/api/'
        ).json()['results'][0]
        self.artist2 = {
            'email': self.artist2['email'],
            'password': self.artist2['login']['password'],
            'first_name': self.artist2['name']['first'],
            'last_name': self.artist2['name']['last'],
            'is_artist': True
        }
        response = self.client.post(
            "/api/signup",
            json=self.artist2,
            content_type='application/json; charset=UTF-8'
        )
        self.artist2_access_token = response.json["access_token"]

        self.event1 = {
                "title": "Title 1",
                "description": "Description 1",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-01",
                "city": "City 1"
            }
        self.event2 = {
                "title": "Title 2",
                "description": "Description 2",
                "poster_link": "https://random.imagecdn.app/500/150",
                "date": "2022-05-02",
                "city": "City 2"
            }

        self.event_ids = []

        response = self.client.post("/api/event",
                                json=self.event1,
                                content_type="application/json; charset=UTF-8",
                                headers = {"Authorization": "Bearer %s" % self.artist_access_token})
        
        self.event_ids.append(response.json["id"])


        response = self.client.post("/api/event",
                            json=self.event2,
                                content_type="application/json; charset=UTF-8",
                                headers = {"Authorization": "Bearer %s" % self.artist2_access_token})

        self.event_ids.append(response.json["id"])
        self.client.post(f"/api/participants/{self.event_ids[1]}",
                                headers = {"Authorization": "Bearer %s" % self.artist_access_token})
        

        self.client.post(f"/api/participants/{self.event_ids[1]}",
                                headers = {"Authorization": "Bearer %s" % self.user_access_token})


    
    ##################################
    ## HELPERS
    #################################

    def add_participant_request(self, id, auth):
        return self.client.post(f"/api/participants/{id}",
                                headers = {"Authorization": "Bearer %s" % auth})
    
    def remove_participant_request(self, id, auth):
        return self.client.delete(f"/api/participants/{id}",
                                headers = {"Authorization": "Bearer %s" % auth})

    def view_participants_request(self, id):
        return self.client.get(f"/api/participants/{id}")


    ############################
    ## POST /api/participants/<event_id>
    ############################

    # Tests what happens with a invalid event id
    def test_add_participant_invalid_requests(self):
        # invalid event id
        invalid_id_response = self.add_participant_request(43376437634, self.user_access_token)

        self.assertEqual(invalid_id_response.status, "404 NOT FOUND")
        self.assertTrue("error" in invalid_id_response.json)
        self.assertEqual(invalid_id_response.json["error"], f"There are no events with the id 43376437634.")

    # Tests auth with random gibberish
    def test_add_participant_auth(self):
        response = self.add_participant_request(self.event_ids[0], "hjsdhjds")
        self.assertEqual(response.status, "422 UNPROCESSABLE ENTITY")

    # Tests auth with stale token  
    def test_add_participant_stale_token(self):
        response = self.add_participant_request(self.event_ids[0], "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY1Mjg4Mjc2NCwianRpIjoiZWQzODE3ZjAtOWI1OC00MDc2LThiZTYtZDRkNGYyZDVhZDY3IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MiwibmJmIjoxNjUyODgyNzY0LCJleHAiOjE2NTI4ODM2NjQsImlzX2FydGlzdCI6ZmFsc2V9.0Ygj8SVXkMjDOFMeyWObFvAbCOZhhUxfyBysURCKGpc")
        self.assertEqual(response.status, "401 UNAUTHORIZED")


    # Tests if a participant can be added
    def test_add_participant_valid(self):
        response = self.add_participant_request(self.event_ids[0], self.user_access_token)
        self.assertEqual(response.status, "201 CREATED")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], "Successfully added the participant")

    # Testing duplicate participant
    def test_add_participant_duplicate(self):
        response2 = self.add_participant_request(self.event_ids[0], self.user_access_token)
        self.assertEqual(response2.status, "201 CREATED")
        self.assertTrue("success" in response2.json)
        self.assertEqual(response2.json["success"], "Successfully added the participant")

        response = self.add_participant_request(self.event_ids[0], self.user_access_token)
        self.assertEqual(response.status, "409 CONFLICT")

    ############################
    ## GET /api/participants/<event_id>
    ############################
     
     # invalid event
    def test_view_participants_invalid_event(self):
        response = self.view_participants_request(43376437634)

        self.assertEqual(response.status, "404 NOT FOUND")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], f"There are no events with the id 43376437634.")


        # empty part list
    def test_view_participants_empty(self):
        response = self.view_participants_request(self.event_ids[0])
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(len(response.json["participants"]), 0)

    # populated participant list testing
    def test_view_participants_populated(self):
        response = self.view_participants_request(self.event_ids[1])
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(response.json["participants"][1]["user_name"], f"{self.artist['first_name']} {self.artist['last_name']}")
        self.assertEqual(response.json["participants"][0]["user_name"], f"{self.user['first_name']} {self.user['last_name']}")

    ############################
    ## DELETE /api/participants/<event_id>
    ############################
    # unauth
    def test_remove_auth(self):
        response = self.remove_participant_request(self.event_ids[0], "hjsdhjds")
        self.assertEqual(response.status, "422 UNPROCESSABLE ENTITY")
       
       
    # invalid event
    def test_remove_invalid_event(self):
        response = self.remove_participant_request(43376437634, self.user_access_token)

        self.assertEqual(response.status, "404 NOT FOUND")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], f"There are no events with the id 43376437634.")

    # not participating in event
    def test_remove_not_participating_case(self):
        response = self.remove_participant_request(self.event_ids[0], self.artist2_access_token)
        self.assertEqual(response.status, "409 CONFLICT")
        self.assertTrue("error" in response.json)

    # valid removal
    def test_valid_single_removal(self):
        response = self.remove_participant_request(self.event_ids[1], self.artist_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], f"Successfully removed the participant(s).")


    ############################
    ## POST /api/participants/share/<event_id>
    ############################

    # sharing test
        # invalid body
            # invalid path
            # invalid domain
        # unauth
        # invalid event id


    ############################
    ## GET /api/participants/get_info/<event_id>
    ############################

    # Non-existent event check
    def test_get_info_check_event(self):
        response = self.client.get(f"/api/participants/get_info/43376437634", 
                    headers = {"Authorization": "Bearer %s" % self.artist_access_token})
        self.assertEqual(response.status, "404 NOT FOUND")

    # Event ownership check
    def test_get_info_event_ownership(self):
        response = self.client.get(f"/api/participants/get_info/{self.event_ids[0]}", 
                    headers = {"Authorization": "Bearer %s" % self.artist_access_token})

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("is_creator" in response.json)
        self.assertTrue(response.json["is_creator"])

    def test_get_info_doesnt_own_event(self):
        response = self.client.get(f"/api/participants/get_info/{self.event_ids[0]}", 
                    headers = {"Authorization": "Bearer %s" % self.artist2_access_token})

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("is_creator" in response.json)
        self.assertFalse(response.json["is_creator"])

    # Tests the case where the user participates in the event
    def test_get_info_participating(self):
        response = self.client.get(f"/api/participants/get_info/{self.event_ids[1]}", 
                    headers = {"Authorization": "Bearer %s" % self.user_access_token})

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("user_participating" in response.json)
        self.assertTrue(response.json["user_participating"])

    # Tests the case where the user is not participated
    def test_get_info_participating(self):
        response = self.client.get(f"/api/participants/get_info/{self.event_ids[0]}", 
                    headers = {"Authorization": "Bearer %s" % self.user_access_token})

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("user_participating" in response.json)
        self.assertFalse(response.json["user_participating"])
    


    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()