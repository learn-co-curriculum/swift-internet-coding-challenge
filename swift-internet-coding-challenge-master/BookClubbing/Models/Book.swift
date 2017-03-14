///
/// BookClubAPI.swift
///

import Foundation
import SwiftyJSON

struct Book {
    let author: String
    let id: Int
    let lastCheckoutDate: String
    let lastCheckedOutBy: String
    let publisher: String
    let title: String
    let url: URL?
    
    var incompleteData: Bool {
        return author == "" || title == ""
    }
    
    init?(from json: JSON) {
        self.author = json["author"].stringValue
        self.id = json["id"].intValue
        self.lastCheckoutDate = json["lastdheckoutdate"].stringValue
        self.lastCheckedOutBy = json["lastcheckedoutby"].stringValue
        self.publisher = json["publisher"].stringValue
        self.title = json["title"].stringValue
        self.url = URL(string: json["url"].stringValue)
        
        if incompleteData { return nil }
    }
}
