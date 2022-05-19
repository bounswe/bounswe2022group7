import unittest

from ..api.art_galleries import get_art_galleries
from .. import create_app


class TestGalleries(unittest.TestCase):
    def setUp(self) -> None:
        app = create_app(testing=True)
        self.context = app.app_context()
        self.context.push()
        self.client = app.test_client()

        self.response = self.client.get(
            "/api/art_galleries"
        )

    def test_five_galleries(self):
        self.assertEqual(len(self.response.json), 5)

    def test_returns_list(self):
        self.assertIsInstance(self.response.json, list)

    def test_returns_art_galleries(self):
        for gallery in self.response.json:
            self.assertIn('Art Gallery', gallery['name'])
