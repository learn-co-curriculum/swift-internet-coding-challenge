//
//  DetailBookViewController.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/15/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import UIKit

class DetailBookViewController: UIViewController {
    
    var book: Book?
    let store = BookDataStore.sharedInstance
    
    @IBOutlet weak var id: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabels()
    }
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookLastCheckedOut: UILabel!
    
    @IBAction func checkOut(_ sender: Any) {
        setupLabels()
        guard let bookID = book?.id else { print ("no no no"); return}
        guard let book = book else {fatalError("Got no books!")}

//        let date = Date()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MM.dd.yyyy"
//        let result = formatter.string(from: date)
        
        let bookDict: [String: Any] = ["id": "\(bookID)",
                    "author": book.author,
                    "publisher" : book.publisher,
                    "title": book.title,
                    "lastcheckedout":  true,
                    "lastcheckedoutby": book.lastcheckedoutby]
                            
        BookClubClient.checkOut(id: "\(bookID)", book: bookDict) {
            print("check up on it")
            self.loadView()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.generateBookList { _ in
//            OperationQueue.main.addOperation({
//                self.setupLabels()  //calling this in viewWillAppear ruins labels
                self.viewDidLoad()
                print("view is loading")
//            })
        }
    }

    func setupLabels() {
        guard let book = book else {fatalError("Got no books!")}
        bookTitle.text = book.title
        author.text = book.author
        bookPublisher.text = book.publisher
        bookLastCheckedOut.text = "Sejan + \(NSDate())"
        id.text = "\(book.id)"
    }



}
