//
//  BookClubClient.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import Foundation
import UIKit


class BookClubClient {
    
    
    static func getBooksJSON(with completion: @escaping ([[String: Any]]) -> ()) {
        let endpoint = "https://flatironchallenge.herokuapp.com/books"
        let url = URL(string: endpoint)
        guard let unwrappedURL = url else { fatalError("Invalid URL") }
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = "GET"
        print("test 1")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else  { fatalError ("Unable to get data")}
            if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                if let dictionaryArray = JSON {
                    completion(dictionaryArray)
                    print("Test 2")
            }
            }
    })
                task.resume()
    }
}

extension BookClubClient {
    class func add(new book: [String: Any], completion: @escaping () -> ()) {
        let endpoint = "https://flatironchallenge.herokuapp.com/books"
        guard let url = URL(string: endpoint) else {fatalError("Not a valid URL")}
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        if let json = try? JSONSerialization.data(withJSONObject: book, options: []) {
        request.httpBody = json
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
            guard let status = response as? HTTPURLResponse else {fatalError("Invalid response")}
            print(status.statusCode)
               completion()
        })
        task.resume()
        }
    }
}

extension BookClubClient {
    class func delete(id: String, completion: @escaping () -> ()) {
        let endpoint = "https://flatironchallenge.herokuapp.com/books/\(id)"
        print(endpoint)
        guard let url = URL(string: endpoint) else {fatalError("Not a valid URL")}
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
            guard let status = response as? HTTPURLResponse else {fatalError("Invalid response")}
            print(status.statusCode)
            print("book deleted")
                return completion()
        })
        task.resume()
}
}

extension BookClubClient {
    class func checkOut(id: String, book: [String: Any], completion: @escaping () -> ()) {
        let endpoint = "https://flatironchallenge.herokuapp.com/books/\(id)"
        guard let url = URL(string: endpoint) else {fatalError("Not a valid URL")}
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let json = try? JSONSerialization.data(withJSONObject: book, options: []) {
            request.httpBody = json
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler:  { (data, response, error) in
            guard let status = response as? HTTPURLResponse else {fatalError("Invalid response")}
            print(status.statusCode)
            print("book checked out")
            return completion()
        })
        task.resume()
    }
}

}
