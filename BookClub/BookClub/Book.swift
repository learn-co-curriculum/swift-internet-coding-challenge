//
//  Book.swift
//  
//
//  Created by ac on 3/14/17.
//
//

import Foundation

class Book {
    let id:UInt
    let title:String
    let author:String
    let publisher:String
    let url:String?
    var lastCheckedOut:Bool?
    var lastCheckedOutBy:String?
    
    init(dict:[String:Any]) {
        id = dict["id"] as? UInt ?? 0
        title = dict["title"] as? String ?? "Invalid Title"
        author = dict["author"] as? String ?? "Invalid Author"
        publisher = dict["publisher"] as? String ?? "Invalid Publisher"
        url = dict["url"] as? String
        lastCheckedOut = dict["lastcheckedout"] as? Bool
        lastCheckedOutBy = dict["lastcheckedoutby"] as? String
    }
}
