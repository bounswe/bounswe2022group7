import unittest

from .. import create_app, db
from ..models import User

from ..api.participants import *

class TestEvent(unittest.TestCase):

    def setUp(self):

        app = create_app(testing=True)
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
        self.user_id = User.query.filter_by(email=self.user['email']).first().id

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
        self.artist_id = User.query.filter_by(email=self.artist['email']).first().id

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
        self.artist2_id = User.query.filter_by(email=self.artist2['email']).first().id

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

        self.invalid_event_id = 587478478
        self.expired_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmcmVzaCI6ZmFsc2UsImlhdCI6MTY1Mjg4Mjc2NCwianRpIjoiZWQzODE3ZjAtOWI1OC00MDc2LThiZTYtZDRkNGYyZDVhZDY3IiwidHlwZSI6ImFjY2VzcyIsInN1YiI6MiwibmJmIjoxNjUyODgyNzY0LCJleHAiOjE2NTI4ODM2NjQsImlzX2FydGlzdCI6ZmFsc2V9.0Ygj8SVXkMjDOFMeyWObFvAbCOZhhUxfyBysURCKGpc"
        self.invalid_token = "sdahkdsahjbsad"

    
    ##################################
    ## HELPERS
    #################################

    def request_add_participant(self, event_id, access_token):
        return self.client.post(f"/api/participants/{event_id}",
                                headers = {"Authorization": f"Bearer {access_token}"})
    
    def request_remove_participant(self, event_id, access_token):
        return self.client.delete(f"/api/participants/{event_id}",
                                headers = {"Authorization": f"Bearer {access_token}"})

    def request_view_participants(self, event_id, access_token):
        return self.client.get(f"/api/participants/{event_id}",
                                        headers = {"Authorization": f"Bearer {access_token}"}) 


    def request_share_link(self, json, event_id, access_token):
        return self.client.post(f"/api/participants/share/{event_id}",
                                        json=json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": f"Bearer {access_token}"}) 


    ############################
    ## POST /api/participants/<event_id>
    ############################

    # Tests what happens with a invalid event id
    def test_add_participant_invalid_requests(self):
        # invalid event id
        invalid_id_response = self.request_add_participant(self.invalid_event_id, self.user_access_token)

        self.assertEqual(invalid_id_response.status, "404 NOT FOUND")
        self.assertTrue("error" in invalid_id_response.json)
        self.assertEqual(invalid_id_response.json["error"], f"There are no events with the id {self.invalid_event_id}.")

    # Tests auth with random gibberish
    def test_add_participant_auth(self):
        response = self.request_add_participant(self.event_ids[0], self.invalid_token)
        self.assertEqual(response.status, "422 UNPROCESSABLE ENTITY")

    # Tests auth with stale token  
    def test_add_participant_stale_token(self):
        response = self.request_add_participant(self.event_ids[0], self.expired_token)
        self.assertEqual(response.status, "401 UNAUTHORIZED")


    # Tests if a participant can be added
    def test_add_participant_valid(self):
        response = self.request_add_participant(self.event_ids[0], self.user_access_token)
        self.assertEqual(response.status, "201 CREATED")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], "Successfully added the participant")

    # Testing duplicate participant
    def test_add_participant_duplicate(self):
        response2 = self.request_add_participant(self.event_ids[0], self.user_access_token)
        self.assertEqual(response2.status, "201 CREATED")
        self.assertTrue("success" in response2.json)
        self.assertEqual(response2.json["success"], "Successfully added the participant")

        response = self.request_add_participant(self.event_ids[0], self.user_access_token)
        self.assertEqual(response.status, "409 CONFLICT")

    ############################
    ## GET /api/participants/<event_id>
    ############################
     
     # invalid event
    def test_view_participants_invalid_event(self):
        response = self.request_view_participants(self.invalid_event_id, self.artist_access_token)

        self.assertEqual(response.status, "404 NOT FOUND")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], f"There are no events with the id {self.invalid_event_id}.")

    # empty part list
    def test_view_participants_empty(self):
        response = self.request_view_participants(self.event_ids[0], self.artist_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(len(response.json["participants"]), 0)

    # populated participant list testing
    def test_view_participants_populated(self):
        response = self.request_view_participants(self.event_ids[1], self.artist_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(response.json["participants"][1]["user_name"], f"{self.artist['first_name']} {self.artist['last_name']}")
        self.assertEqual(response.json["participants"][0]["user_name"], f"{self.user['first_name']} {self.user['last_name']}")
        
    # Event ownership check
    def test_view_participants_event_ownership(self):
        response = self.request_view_participants(self.event_ids[0], self.artist_access_token)

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("is_creator" in response.json)
        self.assertTrue(response.json["is_creator"])

    def test_view_participants_doesnt_own_event(self):
        response = self.request_view_participants(self.event_ids[0], self.artist2_access_token)

        self.assertEqual(response.status, "200 OK")
        self.assertTrue("is_creator" in response.json)
        self.assertFalse(response.json["is_creator"])

    # Tests the case where the user participates in the event
    def test_view_participants_user_participating(self):
        response = self.request_view_participants(self.event_ids[1], self.user_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("user_participating" in response.json)
        self.assertTrue(response.json["user_participating"])

    # Tests the case where the user is not participated
    def test_view_participants_participating(self):
        response = self.request_view_participants(self.event_ids[0], self.user_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("user_participating" in response.json)
        self.assertFalse(response.json["user_participating"])
    

    ############################
    ## DELETE /api/participants/<event_id>
    ############################
    # unauth
    def test_remove_auth(self):
        response = self.request_remove_participant(self.event_ids[0], self.invalid_token)
        self.assertEqual(response.status, "422 UNPROCESSABLE ENTITY")
       
       
    # invalid event
    def test_remove_invalid_event(self):
        response = self.request_remove_participant(self.invalid_event_id, self.user_access_token)

        self.assertEqual(response.status, "404 NOT FOUND")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], f"There are no events with the id {self.invalid_event_id}.")

    # not participating in event
    def test_remove_not_participating_case(self):
        response = self.request_remove_participant(self.event_ids[0], self.artist2_access_token)
        self.assertEqual(response.status, "409 CONFLICT")
        self.assertTrue("error" in response.json)

    # valid removal
    def test_remove_single_valid(self):
        response = self.request_remove_participant(self.event_ids[1], self.artist_access_token)
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], f"Successfully removed the participant(s).")

    # Multiple valid removal
    def test_remove_multiple_valid(self):
        removal_request_json = { "participants": [self.user_id, self.artist_id]}
        response = self.client.delete(f"/api/participants/{self.event_ids[1]}",
                                        json=removal_request_json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": "Bearer %s" % self.artist2_access_token})
        
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], f"Successfully removed the participant(s).")
        check_response = self.request_view_participants(self.event_ids[1], self.artist2_access_token)
        self.assertEqual(check_response.status, "200 OK")
        self.assertEqual(len(check_response.json["participants"]), 0)

    # Check if user creator
    def test_remove_needs_to_be_creator(self):
        removal_request_json = { "participants": [self.user_id, self.artist_id]}
        response = self.client.delete(f"/api/participants/{self.event_ids[1]}",
                                        json=removal_request_json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": "Bearer %s" % self.artist_access_token})
        
        self.assertEqual(response.status, "403 FORBIDDEN")
        self.assertTrue("error" in response.json)
        self.assertEqual(response.json["error"], "User is not the creator of the event")

    # Case which a user given in list is not a participant, will block all removal process
    def test_remove_user_not_participating(self):
        removal_request_json = { "participants": [self.user_id, self.artist_id]}
        response = self.client.delete(f"/api/participants/{self.event_ids[0]}",
                                        json=removal_request_json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": "Bearer %s" % self.artist_access_token})        
        self.assertEqual(response.status, "409 CONFLICT")
        self.assertTrue("error" in response.json)

    # Empty array test
    def test_remove_request_body_empty_array(self):
        removal_request_json = { "participants": []}
        response = self.client.delete(f"/api/participants/{self.event_ids[1]}",
                                        json=removal_request_json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": "Bearer %s" % self.artist2_access_token})
        
        self.assertEqual(response.status, "200 OK")
        self.assertTrue("success" in response.json)
        self.assertEqual(response.json["success"], f"Successfully removed the participant(s).")
        check_response = self.request_view_participants(self.event_ids[1], self.artist2_access_token)
        self.assertEqual(check_response.status, "200 OK")
        self.assertEqual(len(check_response.json["participants"]), 2)


    def test_remove_invalid_request_body(self):
        removal_request_json = { "particiler": [self.user_id, self.artist_id]}
        response = self.client.delete(f"/api/participants/{self.event_ids[0]}",
                                        json=removal_request_json,
                                        content_type = "application/json; charset=UTF-8",
                                        headers = {"Authorization": "Bearer %s" % self.artist_access_token})        
        self.assertEqual(response.status, "400 BAD REQUEST")
        self.assertTrue("error" in response.json)


    ############################
    ## POST /api/participants/share/<event_id>
    ############################

    # # Invalid Event ID
    # def test_share_invalid_event(self):
    #     json = { "page_url": "https://google.com/tr/"}
    #     response = self.request_share_link(json, self.invalid_event_id, self.artist_access_token)
    #     self.assertEqual(response.status, "404 NOT FOUND")

    # # Invalid Request Body                              
    # def test_share_invalid_request_body(self):
    #     json = { "paige_url": "https://google.com/tr/"}
    #     response = self.request_share_link(json, self.event_ids[0], self.artist_access_token)

    #     self.assertEqual(response.status, "400 BAD REQUEST")
    #     self.assertEqual(response.json["error"], "There was an error on key / value pairs on request body.")

    # # Invalid Link
    # def test_share_request_body_invalid_link(self):
    #     json = { "page_url": "not_an_url"}
    #     response = self.request_share_link(json, self.event_ids[0], self.artist_access_token)

    #     self.assertEqual(response.status, "400 BAD REQUEST")
    #     self.assertEqual(response.json["error"], "Not a link")

    # # Expired Token
    # def test_share_expired_token(self):
    #     json = { "page_url": "https://google.com/tr/"}
    #     response = self.request_share_link(json, self.event_ids[0], self.expired_token)
    #     self.assertEqual(response.status, "401 UNAUTHORIZED")

    # # Invalid Token
    # def test_share_invalid_token(self):
    #     json = { "page_url": "https://google.com/tr/"}
    #     response = self.request_share_link(json, self.event_ids[0], self.invalid_token)
    #     self.assertEqual(response.status, "422 UNPROCESSABLE ENTITY")

    # # Valid request
    # def test_share_valid_request(self):
    #     json = { "page_url": "https://google.com/tr/"}
    #     response = self.request_share_link(json, self.event_ids[0], self.artist2_access_token)
    #     self.assertEqual(response.status, "200 OK")
    
    


    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()
