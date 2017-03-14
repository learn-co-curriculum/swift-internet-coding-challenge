### Synopsis

I completed the Swift-Internet-Coding Challenge (BookClub).

### Architecture

The project uses Alamofire to simplify API requests. A library like SwiftyJSON didn't seem necessary at this scale.'The project architecture is lightweight: getting all Books whenever the table view is loaded.

For this scope, I did not use a separate data store. For the detail view, the selected book instance is passed to the controller.

I chose not to implement the 'delete all books' feature as I'm not sure why it would be used and other students are using the database.

### Possible Enhancements

 * Allow users to delete books only if they created them, either by saving an 'added by' field in Heroku or storing books added in UserDefaults
 * Create a 'library card' onboarding system, storing user name in UserDefaults, instead of the default "Ben" currently in the project
 * Design / applicable brand for a library or bookstore
 * Amazon like recommendation features such as similar books, categories, friends, etc.
