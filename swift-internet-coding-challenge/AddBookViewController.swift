//
//  AddBookViewController.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import UIKit

extension UITextField {
    func pulseRed() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4, animations: {
                self.backgroundColor = UIColor.red
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.4, animations: {
                self.backgroundColor = UIColor.white
            })
        }, completion: nil)
    }
}

class AddBookViewController: UIViewController  {
    let store = BookDataStore.sharedInstance
    
    
    @IBAction func done(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var author: UITextField!
    @IBOutlet weak var publisher: UITextField!
    @IBOutlet weak var submit: UIButton!
    @IBOutlet weak var url: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        
        if bookTitle.text == "" || author.text == "" || publisher.text == "" || url.text == "" {
            bookTitle.pulseRed()
            author.pulseRed()
            publisher.pulseRed()
            url.pulseRed()
        } else {
        
        checkTextFields()
        addBook()
        submit.isEnabled = true
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func checkTextFields() {
        guard bookTitle.text != "" else { bookTitle.pulseRed()
        return}
        guard author.text != "" else { author.pulseRed()
            return}
        guard publisher.text != "" else { publisher.pulseRed()
            return}
        guard url.text != "" else { url.pulseRed()
            return}
    }
    
    func addBook() {
         let bookToAdd: [String: Any] =  ["author":  author.text ?? "no author",
                                         "publisher":  publisher.text ??  "No publisher",
                                         "title": bookTitle.text ?? "No title",
                                         "url": url.text ?? "No url"]
        BookClubClient.add(new: bookToAdd) {
            print(bookToAdd)
        }
    }
}

