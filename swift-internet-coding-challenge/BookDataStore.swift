//
//  BookDataStore.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import Foundation
import UIKit

class BookDataStore {

static let sharedInstance = BookDataStore()
    
var books = [Book]()
    fileprivate init() {}
    
    func generateBookList( completion: @escaping () -> ()) {
        BookClubClient.getBooksJSON { (JSONObject) in
            self.books.removeAll()
            for book in JSONObject {
                let finishedBook = Book(dictionary: book)
                self.books.append(finishedBook)
            }
            completion()
    }
}

}
