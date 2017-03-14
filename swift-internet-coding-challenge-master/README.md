## Book Club

**OVERVIEW**

An application that interacts with the books JSON API hosted on [Heroku](https://flatironchallenge.herokuapp.com).  The [APIClient](https://github.com/OLI9292/swift-internet-coding-challenge/blob/master/BookClubbing/Networking/BookClubAPI.swift) can retrieve books to display in a [table view](https://github.com/OLI9292/swift-internet-coding-challenge/blob/master/BookClubbing/Views/BooksVC.swift), show the details of those books in a [detail view](https://github.com/OLI9292/swift-internet-coding-challenge/blob/master/BookClubbing/Views/BookDetail.swift), and update or create books.

**DATA**

Data for the views is stored in a [Data Store](https://github.com/OLI9292/swift-internet-coding-challenge/blob/master/BookClubbing/Data/Store.swift) to avoid repetitive API requests when moving between views.

**LIBRARIES**

- [Alamofire](https://github.com/Alamofire/Alamofire) for networking
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) for JSON parsing
- [Then](https://github.com/devxoul/Then) for code legibility
