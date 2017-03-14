//
//  DetailViewController.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var checkoutButton: UIButton!
    @IBOutlet weak var lastCheckOutLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let book = book {
            print("book last checkout is \(book.lastCheckedOut) and by is \(book.lastCheckedOutBy)")
            titleLabel.text = book.title
            authorLabel.text = book.author
            publisherLabel.text = book.publisher
            lastCheckOutLabel.text = book.lastCheckedOutBy
    
        }
        
    }
    
    @IBAction func checkoutAction(_ sender: Any) {
        guard let book = book else { return }

        APIClient.checkoutbook(name: "Ben", timeStamp: currentTime(), id: book.id) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
