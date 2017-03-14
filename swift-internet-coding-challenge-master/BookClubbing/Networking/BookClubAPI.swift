///
/// BookClubAPI.swift
///

import Alamofire
import SwiftyJSON
import Foundation

final class BookClubAPI {
    
    static let shared = BookClubAPI()
    
    let baseUrl = "https://flatironchallenge.herokuapp.com/books"
    
    func getBooks(completion: @escaping ([Book]) -> ()) {
        Alamofire.request(baseUrl).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let json = JSON(data: data)
                let books = json.arrayValue.flatMap { Book(from: $0) }
                completion(books)
            default:
                print("BookClubAPI -> bad request GET /books")
                completion([])
            }
        }
    }

    func checkoutBook(id: Int, for name: String, completion: @escaping (Book?) -> ()) {
        let endpoint = "\(baseUrl)/\(id)"
        let parameters: Parameters = ["lastcheckedoutby": name]
        Alamofire.request(endpoint, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let json = JSON(data: data)
                let book = Book(from: json)
                completion(book)
            default:
                print("BookClubAPI -> bad request PUT /books/\(id)")
                completion(nil)
            }
        }
    }
    
    func addBook(params: [String : String], completion: @escaping (Book?) -> ()) {
        let parameters: Parameters = params
        Alamofire.request(baseUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                let json = JSON(data: data)
                let book = Book(from: json)
                completion(book)
            default:
                print("BookClubAPI -> bad request POST /books")
                completion(nil)
            }
        }
    }
}
