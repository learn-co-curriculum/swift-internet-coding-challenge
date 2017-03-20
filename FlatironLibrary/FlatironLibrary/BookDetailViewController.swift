//
//  BookDetailViewController.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/14/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var lastDateCheckedOut: UILabel!
    var book: Book?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Detail"
        
        setupDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupDetails() {
        if let unwrappedBook = book {
        self.bookAuthor.text = "Author: \(unwrappedBook.author)"
        self.bookTitle.text = unwrappedBook.title
        self.bookPublisher.text = "Publisher: \(unwrappedBook.publisher)"
        self.lastDateCheckedOut.text = "Last Checked Out: \n\(unwrappedBook.lastCheckedOut)"
        }
    }

    @IBAction func checkoutBook(_ sender: Any) {
        guard let unwrappedBook = book else { return }
        let checkoutDetails: [String: Any] = [
            "lastcheckedout": true,
            "lastcheckedoutby": "Pree \(NSDate())",
        ]
        LibraryAPIManager.checkoutBook(parameters: checkoutDetails, bookID: unwrappedBook.bookID) {
            print("Checked out \(book?.title)")
        }
    }
    
    
    
}
