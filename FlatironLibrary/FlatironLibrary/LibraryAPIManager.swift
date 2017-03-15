//
//  LibraryAPIManager.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/13/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import Foundation
import Alamofire

class LibraryAPIManager {
        
    
    //JSON request returns type [[String: Any]]
    
    fileprivate init() { }
    
    static func getBooks(completion: @escaping ([[String: Any]]) -> ()) {
        let url = URL(string: booksURL)
        guard let unwrappedUrl = url else { fatalError("Invalid URL") }
        Alamofire.request(unwrappedUrl).responseJSON { (response) in
            if let JSON = response.result.value as? [[String: Any]] {
                completion(JSON)
            } else {
                fatalError("Invalid JSON object")
            }
        }
    }
    
    static func addBook(parameters: [[String: Any]], completion: @escaping () -> () ) {
//        Alamofire.request(booksURL, method: .post, parameters: parameters, encoding: JSONEncoding, headers: nil)
    }
    
    static func updateBook() {
        
    }
    
    static func deleteBook() {
        
    }
    
}



