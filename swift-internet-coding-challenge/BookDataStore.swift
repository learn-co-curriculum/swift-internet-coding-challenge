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
weak var delegate: BookDataStoreDelegate?
    
var books = [Book]()
    fileprivate init() {}
    
    func generateBookList( completion: @escaping () -> ()) {
        self.books.removeAll()
        BookClubClient.getBooksJSON { (JSONObject) in
            for book in JSONObject {
                let finishedBook = Book(dictionary: book)
                self.books.append(finishedBook)
            }
            completion()
    }
}

}

protocol BookDataStoreDelegate: class {
    
    func updateWithNewData()
    
}
