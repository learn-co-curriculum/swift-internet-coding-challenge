//
//  Book.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    var author: String
    var id: Int
    var lastcheckedout: Bool?
    var lastcheckedoutby: String = "Sejan + \(NSDate())"
    var publisher: String
    var title: String
    var url: String
    
    init(dictionary: [String: Any]) {
        guard let
        author =  dictionary["author"] as? String,
        let id = dictionary["id"] as? Int,
//        let lastcheckedout = dictionary["lastcheckedout"] as? Bool,
//        let lastcheckedoutby = dictionary["lastcheckedoutby"] as? String,
        let publisher =  dictionary["publisher"] as? String,
        let title = dictionary["title"] as? String,
        let url = dictionary["url"] as? String
        else {fatalError("Could not create dictionary")}
        
        self.author = author
        self.id = id
//        self.lastcheckedout = lastcheckedout
//        self.lastcheckedoutby = lastcheckedoutby
        self.publisher = publisher
        self.title = title
        self.url = url
    }
    
    //        let date = Date()
    //        let formatter = DateFormatter()
    //        formatter.dateFormat = "MM.dd.yyyy"
    //        let result = formatter.string(from: date)
    
    
}
