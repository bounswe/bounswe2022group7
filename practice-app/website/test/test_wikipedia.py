import unittest

from .. import create_app, db

class TestEvent(unittest.TestCase):

    def setUp(self):

        app = create_app()
        self.ctx = app.app_context()
        self.ctx.push()
        self.client = app.test_client()

    def make_wikipedia_request(self, word):
        data = {
            "word": word
        }
        return self.client.post("/api/wikipedia_definition",
                                json=data,
                                content_type="application/json; charset=UTF-8")

    # test wikipedia_definition API endpoint

    def test_none(self):
        response = self.client.post("/api/wikipedia_definition",
                                json={},
                                content_type="application/json; charset=UTF-8")
        self.assertEqual(response.status, "400 BAD REQUEST")

    def test_empty(self):
        response = self.make_wikipedia_request("")    
        self.assertEqual(response.status, "400 BAD REQUEST")

    def test_a(self):
        response = self.make_wikipedia_request("a")    
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(response.json["definition"][0], "A")

    def test_pizza(self):
        response = self.make_wikipedia_request("pizza")    
        self.assertEqual(response.status, "200 OK")
        self.assertEqual(response.json["definition"][0:5], "Pizza")

    def tearDown(self):
        db.drop_all()
        self.ctx.pop() 

if __name__ == "__main__":
    unittest.main()
