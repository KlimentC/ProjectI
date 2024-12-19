import unittest
from app.app import app

class TestApp(unittest.TestCase):
    def setUp(self):
        """Set up the test client before each test."""
        self.client = app.test_client()

    def test_home_page(self):
        """Test the root route '/'."""
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Welcome to My App!", response.data)

    def test_about_page(self):
        """Test the '/about' route."""
        response = self.client.get("/about")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"About This App", response.data)

    def test_api_greet_default(self):
        """Test the '/api/greet' route with no name parameter."""
        response = self.client.get("/api/greet")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"message": "Hello, World!"})

    def test_api_greet_with_name(self):
        """Test the '/api/greet' route with a name parameter."""
        response = self.client.get("/api/greet?name=Alice")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.json, {"message": "Hello, Alice!"})

    def test_submit_form(self):
        """Test the '/submit' route with POST method."""
        response = self.client.post("/submit", data={"name": "Bob"})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Hello, Bob!", response.data)

    def test_submit_form_default(self):
        """Test the '/submit' route with POST method without a name."""
        response = self.client.post("/submit")
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Hello, Guest!", response.data)


if __name__ == "__main__":
    unittest.main()
