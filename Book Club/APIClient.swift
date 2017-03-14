//
//  APIClient.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import Alamofire

final class APIClient {
    
    class func getBooks(completion: @escaping ([Book]) -> Void ) {
        Alamofire.request("https://flatironchallenge.herokuapp.com/books").responseJSON { response in
            if let JSON = response.result.value {
                let arrayOfBooks = JSON as! [[String:Any]]
                var returnBooks = [Book]()
                for book in arrayOfBooks {
                    let book = Book(dict: book)
                    returnBooks.append(book)
                }
                completion(returnBooks)
            }
        }
    }
    
    class func postBook(author: String, title: String, publisher: String, url: String, completion: @escaping () -> Void) {
        
        let parameters: Parameters = [
            "title": title,
            "url": url,
            "publisher": publisher,
            "author": author
        ]
        
        Alamofire.request("https://flatironchallenge.herokuapp.com/books", method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Book Added Succesfully")
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
        
    }
    
    class func checkoutbook(name: String, timeStamp: String, id: Int, completion: @escaping () -> Void) {
        
        let parameters: Parameters = [
            // TODO - user defaults add name
            "lastcheckedoutby" : "Ben at \(timeStamp)"
        ]
        
        Alamofire.request("https://flatironchallenge.herokuapp.com/books/\(id)", method: .put, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Book Checked Out Succeesfully")
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
        
    }

    
    
}




