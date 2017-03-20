//
//  Book.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/13/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import Foundation

class Book: CustomStringConvertible {
    let author: String
    var lastCheckedOut: String
    var lastCheckedOutBy: String
    let publisher: String
    let title: String
    let url: String
    let bookID: Int
    var description: String {
        return "Title: \(self.title)\nAuthor: \(self.author)\nPublisher: \(self.publisher)\nLast Checked Out: \(self.lastCheckedOut)\nLastCheckedOutBy: \(self.lastCheckedOutBy)\nURL: \(self.url)"
    }
    
    init(dict: [String: Any]) {
        self.author = dict["author"] as? String ?? "N/A"
        self.lastCheckedOut = dict["lastCheckedOut"] as? String ?? "Be the first to check out this book!"
        self.lastCheckedOutBy = dict["lastCheckedOutBy"] as? String ?? "N/A"
        self.publisher = dict["publisher"] as? String ?? "N/A"
        self.title = dict["title"] as? String ?? "N/A"
        self.url = dict["url"] as? String ?? "N/A"
        self.bookID = dict["id"] as? Int ?? 0
    }
    
    
}















