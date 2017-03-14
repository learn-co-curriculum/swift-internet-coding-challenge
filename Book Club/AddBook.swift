//
//  AddBook.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation
import UIKit

class AddBookViewController: UIViewController {
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var publisherField: UITextField!
    @IBOutlet weak var urlField: UITextField!
    var fields = [UITextField]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fields = [titleField, authorField, publisherField, urlField]
        
    }
    
    func determineInvalidForm() -> String {
        var missingFields = String()
        fields.forEach { if $0.text == "" { missingFields += $0.placeholder! + " \n "} }
        return missingFields
    }
    
    @IBAction func submitAction(_ sender: Any) {
        
        if titleField.text != "" && authorField.text != "" && publisherField.text != "" && urlField.text != ""  {
            APIClient.postBook(author: authorField.text!, title: titleField
                .text!, publisher: publisherField.text!, url: urlField.text!
                , completion: { Void in
                    self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Missing Required Information", message: determineInvalidForm(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil ))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        var textEntered = false
        fields.forEach { if $0.text != "" { textEntered = true }
            if !textEntered  {
                self.dismiss(animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Are You Sure?", message: "You Have Entered Text", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Go Back", style: .default, handler: nil))
                alert.addAction(UIAlertAction(title: "I'm Sure", style: .default ) { (UIAlertAction) -> Void in
                    self.dismiss(animated: true, completion: nil)
                })
                present(alert, animated: true, completion: nil)
        }
    }
}
}


        
