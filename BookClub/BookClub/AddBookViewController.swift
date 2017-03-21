//
//  AddBookViewController.swift
//  BookClub
//
//  Created by ac on 3/15/17.
//  Copyright © 2017 amitc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AddBookViewController:UIViewController {
    
    var bookIndex:UInt?
    let singleton = Catalog.sharedBookList
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var publisher: UITextField!
    @IBOutlet weak var url: UITextField!
    
   
    @IBAction func doneAction(_ sender: UIButton) {
        if bookTitle.text?.characters.count != 0 || author.text?.characters.count != 0 || publisher.text?.characters.count != 0 || url.text?.characters.count != 0 {
            let alertController = UIAlertController(title: "WARNING", message: "Do you wish to leave with unsaved data?", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .destructive, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)         // destructive, cancel do not close the window.
                //...
                })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                //...
            })
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: {  })
            
            

            
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        if bookTitle.text?.characters.count == 0 || author.text?.characters.count == 0 {
            let alertController = UIAlertController(title: "Error", message: "Title or author cannot be empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                //...
            })
            
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            let bookDict = ["title":bookTitle.text ?? "", "author":author.text ?? "", "publisher":publisher.text ?? "", "url":self.url.text ?? "" ] as [String : Any]
            //let book = Book(dict: bookDict)     //put in local storage
            //singleton.bookList.append(book)
            addBook(dict: bookDict)
            print("In submitAction: After addBook()")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    func addBook(dict:[String:Any]) {
        
        //let dict = ["title":bookTitle.text ?? "", "author":author.text ?? "", "publisher":publisher.text ?? "", "url":self.url.text ?? "" ] as [String : Any]
        
       /* Alamofire.request("https://flatironchallenge.herokuapp.com/books", method: .post, parameters: dict, encoding: JSONEncoding.default).validate().responseJSON { (response) in
                    switch response.result {
                        case .success:
                                print("Book Added Succesfully")
                                print("response:\(response)")
                                    //completion()
                        case .failure(let error):
                                print(error)
                                //completion()
                    }
        } */
        
        guard let url = URL(string: "https://flatironchallenge.herokuapp.com/books") else {
            print("Invalid Url"); return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        

        print("dict:\(dict)")
        let jsonData = try? JSONSerialization.data(withJSONObject: dict)
        
        print("jsonData:\( jsonData)")
        urlRequest.httpBody = jsonData
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")  //Imp
        
        
        let datatask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            //guard let unwrappedJson = responseJson else { print("Invalid responseJson data"); return  }
            print("addBook:data:\(data)")
            print("addBook:response:\(response)")
            print("addBook:error:\(error)")
            //print("unwrappedJson:\(unwrappedJson)")
//            for bookData in unwrappedJson {
//                let book = Book( dict: bookData)
//                self.singleton.bookList.append(book)
//                print("id:\(book.id) title:\(book.title)")
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        datatask.resume()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In AddBookViewController")
        
    }
    
    
    
    
}
