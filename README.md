
The BookClub committee is looking for a way to track who has which book from our library. The goal of this exercise is to create a simple app that connects to a web server and performs a GET, a POST, and a PUT. You may use 3rd party libraries for this app.

###Requirements

 
You should include a README, that contains at least some implementation details (architecture, technical decisions explanation, etc.)


###Wireframes

Screen 1: This screen lists the books in the library. Pressing the + button brings you to the Add Book screen in a modal. Pressing an item in the table brings you to the Detail screen.

![](http://prolific-interview.herokuapp.com/static/ios/screen-1.png)

Screen 2: This screen provides detail about a book. Pressing the Checkout button asks you for your name, and will update the book entry to list your name and the current date for the lastCheckedOut and lastCheckedOutBy fields.

![](http://prolific-interview.herokuapp.com/static/ios/screen-2.png)


Screen 3: This screen is a form to add a new book to the library. Title, author, category and url fields are required. If any of those is empty and Submit is pressed, an alert with an error message is shown. Pressing the Done button will close this screen. If there is text entered in any of the fields, it will confirm that the user wants to leave the screen with unsaved changes.

![](http://prolific-interview.herokuapp.com/static/ios/screen-3.png)

Notes and Other features:

The wireframes should be considered as guidelines / examples. Feel free to design the app the way you want, both on the UI and UX side

* The app should allow users to update a book information
* The app should allow users to delete a specific book
* The app should allow users to delete all books at once


##Endpoints

###Server: https://flatironchallenge.herokuapp.com/


###List all Library Books

GET /books



Sample Response:

```
Status 200 Ok
[
    {
        "author": "Jim Campagno",
        "id": 1,
        "lastCheckedOut": null,
        "lastCheckedOutBy": null,
        "publisher": "O'REILLY",
        "title": "Running Lean",
        "url": "http://books.google.com/books/content?id=2bqGKwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    },
    {
        "author": "Jim Collins",
        "id": 2,
        "lastCheckedOut": null,
        "lastCheckedOutBy": null,
        "publisher": "HarperBusiness; 1 edition",
        "title": "Good to Great: Why Some Companies Make the Leap...And Others Don't",
        "url": "http://books.google.com/books/content?id=2bqGKwAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api"
    }
]

```

###Add a Library Book

POST /books

```
Sample Params:

{
    "author": "Ash Maurya",
    "title": "Running Lean",
    "publisher": "O'REILLY",
    "url":""
}
Sample Response:


Status 200 Ok
{
    "author": "Ash Maurya",
    "title": "Running Lean",
    "publisher": "O'REILLY",
    "url":""
}

```
###Get a Library Book

GET /books/1

```

Sample Response:

Status 200 Ok
{
    "author": "Ash Maurya",
    "categories": "process",
    "id": 1,
    "lastCheckedOut": null,
    "lastCheckedOutBy": null,
    "publisher": "O'REILLY",
    "title": "Running Lean",
    "url": "/books/1/"
}
```


###Update a Library Book

PUT /books/1

```
Sample Params:

{
    "lastCheckedOutBy": "Prolific Pablo"
}
Sample Response:

Status 200 Ok
{
    "author": "Ash Maurya",
    "categories": "process",
    "id": 1,
    "lastCheckedOut": "2014-10-1 19:16:11",
    "lastCheckedOutBy": "Prolific Pablo",
    "publisher": "O'REILLY",
    "title": "Running Lean",
    "url": "/books/1"
}

```


###Delete a Library Book

DELETE /books/1

```
Response:

Status 200 
Clear all Books

```
