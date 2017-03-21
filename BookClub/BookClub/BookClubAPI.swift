//
//  BookClubAPI.swift
//  BookClub
//
//  Created by ac on 3/20/17.
//  Copyright © 2017 amitc. All rights reserved.
//

import Foundation

import Alamofire

class BookClubAPI {

    let singleton = Catalog.sharedBookList
    
    func getBooks(id:String, completion:@escaping ([[String:Any]]?)->()) {
        var responseJson:[[String:Any]]?
        var url:URL
        
        if id == "0" {
            self.singleton.bookList = []
            guard let tmpUrl = URL(string: "https://flatironchallenge.herokuapp.com/books") else {
            print("Invalid Url"); return }
            url = tmpUrl
        } else {
            guard let tmpUrl = URL(string: "https://flatironchallenge.herokuapp.com/books/\(id)") else {
                print("Invalid Url"); return }
            url = tmpUrl
        }
            let datatask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let json = try! JSONSerialization.jsonObject(with: data!, options: [])  as? [[String:Any]] {
                responseJson = json
            }
            //Any: because id is Uint
                else {
                    print("Invalid data")
                    return
            }
            //print("json:\(json)")
        
           completion(responseJson)
        }
        datatask.resume()
        //return responseJson
    } //func getBooks()

    
    func updateBook(id:String, dict:[String:Any], completion:@escaping ([[String:Any]])->()) {
 
        print("updateBook:dict:\(dict)")
        let urlString = "https://flatironchallenge.herokuapp.com/books/\(id)"
        
        
        Alamofire.request(urlString, method: .put, parameters: dict, encoding: JSONEncoding.default, headers: nil).validate().responseJSON {  (response) in
                switch response.result {
                case .success:
                    print("Book Updated Succesfully")
                    print("response:\(response)")
                    completion([response.result.value as! [String : Any]])
                case .failure(let error):
                    print(error)
                    //completion(response.result.value as! [[String : Any]])
            }
            
        }
        
 
       /* guard let url = URL(string: "https://flatironchallenge.herokuapp.com/books/1") else {
            print("Invalid Url"); return }
        let datatask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let json = try! JSONSerialization.jsonObject(with: data!, options: [])  as? [[String:Any]] {
                responseJson = json
            }
                //Any: because id is Uint
            else {
                print("Invalid data")
                return
            }
            //print("json:\(json)")
            
            completion(responseJson)
        }
        datatask.resume()
        */
        
    } //func updateBook

    
    //delete book
    func deleteBook(id:String, completion:@escaping ()->()) {
        let urlString = "https://flatironchallenge.herokuapp.com/books/\(id)"
        
        Alamofire.request(urlString, method: .delete, parameters: [:], encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
            switch response.result {
            case .success:
                print("Book id=\(id) deleted")
                print("response:\(response)")
                completion()
            case .failure(let error):
                fatalError("Book delete failed. Error:\(error)")
            }
            
        }  //Alamofire.request
        
    } //func deleteBook
    
}
