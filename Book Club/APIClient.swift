//
//  APIClient.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
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
}
