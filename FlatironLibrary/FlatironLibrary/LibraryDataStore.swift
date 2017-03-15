//
//  LibraryDataStore.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/14/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import Foundation

class LibraryDataStore {
    static let sharedInstance = LibraryDataStore()
    
    fileprivate init() { }
    
    var books: [Book] = []
    
    func createBooks(completion: @escaping () -> ()) {
        LibraryAPIManager.getBooks { (JSONObjects) in
            self.books.removeAll()
            for object in JSONObjects {
                let book = Book(dict: object)
                self.books.append(book)
            }
            print("The DataStore's book array holds \(self.books.count) books")
            completion()
        }
    }
    
}
