from http import HTTPStatus
import unittest

import datetime

from requests import request

from .. import create_app, db
from ..models import CopyrightInfringementReport

from ..api.art_item import create_art_item_record

import requests
from unittest import mock

TEST_DB_NAME = "test_database.db"


class TestCopyrightInfringementReport(unittest.TestCase):

    def setUp(self):

        app = create_app(TEST_DB_NAME)
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

        # create the first artist object (artist #1) in order to set it
        #  as the owner of all pre-created art items
        self.initial_artist_data = {
            "email": "first_creator@mail.com",
            "password": "first",
            "first_name": "FirstCreator",
            "last_name": "TestArtist",
            "is_artist": "on"
        }
        response = self.client.post("/api/signup",
                                    json=self.initial_artist_data,
                                    content_type="application/json; charset=UTF-8")
        self.assertEqual(response.status, "201 CREATED")

        # the artist user to be used
        self.artist_data = {
            "email": "artist@mail.com",
            "password": "pass",
            "first_name": "ArtistName",
            "last_name": "Test",
            "is_artist": "on"
        }

        # the regular user to be used
        self.user_data = {
            "email": "user@mail.com",
            "password": "pass",
            "first_name": "UserName",
            "last_name": "Test",
            "is_artist": None
        }

        # art item objects to be used
        self.art_item_data = [
            {
                "id": 1,
                "name": "Art Item 1",
                "description": "Art Description 1",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 1)
            },
            {
                "id": 2,
                "name": "Art Item 2",
                "description": "Art Description 2",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 2)
            },
            {
                "id": 3,
                "name": "Art Item 3",
                "description": "Art Description 3",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 3)
            },
                        {
                "id": 4,
                "name": "Art Item 4",
                "description": "Art Description 4",
                "creator_artist": 1,
                "content_uri": "https://random.imagecdn.app/500/150",
                "creation_date": datetime.datetime(2022, 8, 4)
            }
        ]

        # copyright report objects to be used
        self.copyright_report_data = [
            {
                "id": 1,
                "creator": 1,
                "original_art_item_id": 1,
                "infringement_art_item_id": 2,
                "description": "Report Description 1",
                "similarity_score": 27,
                "creation_date": datetime.datetime(2022, 8, 5)
            },
            {
                "id": 2,
                "creator": 1,
                "original_art_item_id": 1,
                "infringement_art_item_id": 3,
                "description": "Report Description 2",
                "similarity_score": 37,
                "creation_date": datetime.datetime(2022, 8, 6)
            }
        ]

        # test data that will be used for creating new reports
        self.create_report_data = {
            "original_art_item_id": "2",
            "infringement_art_item_id": "4",
            "description": "Report Description (Test Data)"
        }

        # test data that will be used for creating new reports
        self.same_art_items_report_data = {
            "original_art_item_id": "1",
            "infringement_art_item_id": "1",
            "description": "Report Description (Test Data)"
        }

        # test data that will be used for creating new reports
        self.nonexist_art_item_report_data = {
            "original_art_item_id": "100",
            "infringement_art_item_id": "1",
            "description": "Report Description (Test Data)"
        }


        # get access token for the test artist user
        response = self.client.post("/api/signup",
                                    json=self.artist_data,
                                    content_type="application/json; charset=UTF-8")

        self.artist_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        # get access token for the test regular user
        response = self.client.post("/api/signup",
                                    json=self.user_data,
                                    content_type="application/json; charset=UTF-8")
        self.user_access_token = response.json["access_token"]
        self.assertEqual(response.status, "201 CREATED")

        # push the prepared art items to the database, and get the ID list
        self.art_item_ids = []
        for json in self.art_item_data:
            art_item = create_art_item_record(json)
            db.session.add(art_item)
            db.session.commit()
            self.art_item_ids.append(json["id"])

        # push the prepared reports to the database, and get the ID list
        self.report_ids = []
        for json in self.copyright_report_data:
            new_copyright_report = CopyrightInfringementReport(
                creator = json["creator"],
                original_art_item_id = json["original_art_item_id"],
                infringement_art_item_id = json["infringement_art_item_id"],
                description = json["description"],
                similarity_score = json["similarity_score"],
                creation_date = json["creation_date"]
            )
            db.session.add(new_copyright_report)
            db.session.commit()
            self.report_ids.append(json["id"])

    # helper functions to prepare the requests

    def make_report_infringement_request(self, json, token):
        return self.client.post("/api/copyright",
                                json=json,
                                content_type="application/json; charset=UTF-8",
                                headers={"Authorization": "Bearer %s" % token})

    def make_get_copyright_report_data_request(self, report_id, token):
        return self.client.get(f"/api/copyright/{report_id}",
                                content_type="application/json; charset=UTF-8",
                                headers={"Authorization": "Bearer %s" % token})

    def make_remove_art_item_request(self, json, token):
        return self.client.delete("/api/copyright",
                                json=json,
                                content_type="application/json; charset=UTF-8",
                                headers={"Authorization": "Bearer %s" % token})

    # test get_copyright_report_data API endpoint

    def test_get_copyright_report_data_succes(self):
        response = self.make_get_copyright_report_data_request(self.report_ids[0], self.user_access_token)
        self.assertEqual(response.status, "200 OK")

    def test_get_copyright_report_data_report_id_notfound(self):
        response = self.make_get_copyright_report_data_request(self.report_ids[-1] + 1, self.user_access_token)
        self.assertEqual(response.status, "404 NOT FOUND")

# test report_infringement API endpoint
    @mock.patch('requests.post')
    def test_report_infringement_succes(self, mock_register):
        mock_response = mock.Mock(status_code=200)
        mock_response.json.return_value = {
            'id': 'c83a2237-8443-4d40-9f67-fc1f32c5c829', 
            'output': {'distance': 26}
        }
        mock_register.return_value = mock_response  

        response = self.make_report_infringement_request(
            self.create_report_data, self.user_access_token)

        self.assertEqual(response.status, "201 CREATED")  # report created
        # its id is correct
        self.assertEqual(response.json["id"], self.report_ids[-1] + 1)

        # the element is in the database
        self.assertIsNotNone(CopyrightInfringementReport.query.get(response.json["id"]))
        self.assertIsNone(CopyrightInfringementReport.query.get(response.json["id"] + 1))

    @mock.patch('requests.post')
    def test_report_infringement_external_api_error(self, mock_register):
        mock_response = mock.Mock(status_code=400)
        mock_response.json.return_value = {
            'error': 'error'
        }
        mock_register.return_value = mock_response  

        response = self.make_report_infringement_request(
            self.create_report_data, self.user_access_token)

        self.assertEqual(response.status, "400 BAD REQUEST")


    def test_report_infringement_same_art_items(self):
        response = self.make_report_infringement_request(
            self.same_art_items_report_data, self.user_access_token)
        self.assertEqual(response.status, "400 BAD REQUEST")

    def test_report_infringement_nonexist_art_item(self):
        response = self.make_report_infringement_request(
            self.nonexist_art_item_report_data, self.user_access_token)
        self.assertEqual(response.status, "404 NOT FOUND")

    # test remove_art_item API endpoint

    def test_remove_art_item_succes(self):
        response = self.make_remove_art_item_request({"art_item_id": f"{self.art_item_ids[0]}"}, self.user_access_token)

        self.assertEqual(response.status, "200 OK")  # reported art item deleted
        # its id is correct
        self.assertEqual(response.json["id"], f"{self.art_item_ids[0]}")

        # the element is not in the database
        self.assertIsNone(CopyrightInfringementReport.query.get(self.art_item_ids[0]))

    def test_remove_art_item_nonexist_art_item(self):
        response = self.make_remove_art_item_request({"art_item_id": f"{self.art_item_ids[-1] + 1}"}, self.user_access_token)
        self.assertEqual(response.status, "404 NOT FOUND")



    def tearDown(self):
        db.drop_all()
        self.ctx.pop()


if __name__ == "__main__":
    unittest.main()
