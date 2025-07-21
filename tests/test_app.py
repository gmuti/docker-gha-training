import pytest
from app.main import app

@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client

def test_get_books(client):
    response = client.get("/books")
    assert response.status_code == 200
    assert len(response.json) > 0

def test_get_book(client):
    response = client.get("/books/1")
    assert response.status_code == 200
    assert "title" in response.json

def test_book_not_found(client):
    response = client.get("/books/999")
    assert response.status_code == 404
    assert "error" in response.json

def test_add_book(client):
    new_book = {"title": "Test Book", "author": "Test Author", "year": 2023}
    response = client.post("/books", json=new_book)
    assert response.status_code == 201
    assert response.json["title"] == "Test Book"