//
//  AddBookViewController.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
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
        checkTextFields()
        addBook()
        submit.isEnabled = true
        self.dismiss(animated: true) {
            print("dismissed")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pulseRed(_ viewAnimate: UIView) {
        let numberOfFrames  = 2.0
        let relativeDuration = 0.5/numberOfFrames
        UIView.animateKeyframes(withDuration: numberOfFrames, delay: 0.0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: relativeDuration, animations: {
                viewAnimate.backgroundColor = UIColor.red
                viewAnimate.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: relativeDuration, animations: {
                viewAnimate.backgroundColor = UIColor.white
                viewAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        }, completion: nil)
    }
    
    func checkTextFields() {
        guard bookTitle.text != "" else { pulseRed(bookTitle)
        fatalError("Not a valid text field")}
        guard author.text != "" else { pulseRed(author)
            fatalError("Not a valid text field")}
        guard publisher.text != "" else { pulseRed(publisher)
            fatalError("Not a valid text field")}
        guard url.text != "" else { pulseRed(url)
            fatalError("Not a valid text field")}
    }
    
    func addBook() {
        guard let bookToAdd: [String: Any] =  ["author":  author.text,
                                         "publisher":  publisher.text,
                                         "title": bookTitle.text,
                                         "url": url.text] else {print ("Not a valid dictionary"); return}
        BookClubClient.add(new: bookToAdd) {
            print(bookToAdd)
        }
    }
    
    
}
