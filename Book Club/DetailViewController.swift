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
            titleLabel.text = book.title
            authorLabel.text = book.author
            publisherLabel.text = book.publisher
            lastCheckOutLabel.text = (book.lastCheckedOut ?? "") + (book.lastCheckedOutBy ?? "")
    
        }
        
        
    }
    
    @IBAction func checkoutAction(_ sender: Any) {
    }
}
