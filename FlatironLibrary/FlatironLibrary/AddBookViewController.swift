//
//  AddBookViewController.swift
//  
//
//  Created by Kaypree Hodges on 3/14/17.
//
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var bookAuthor: UITextField!
    @IBOutlet weak var publisher: UITextField!
    @IBOutlet weak var bookURL: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Book"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func addBook() {
        //Force unwraping is used here since we are checking for any nil values beforehand
        
        let book: [String: Any] = [
            "author": bookAuthor.text!,
            "title": bookTitle.text!,
            "publisher":publisher.text!,
            "url": bookURL.text!
        ]
        LibraryAPIManager.addBook(parameters: book) { 
            
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let allfieldsCompleted = (bookAuthor.text != "") && (bookTitle.text != "") && (publisher.text != "") && (bookURL.text != "")
        
        if allfieldsCompleted {
            addBook()
            self.dismiss(animated: true, completion: nil)
        } else {
            //create UI Alert for incomplete fields
            let alertController = UIAlertController(title: "Incomplete", message: "Please complete all fields before submitting", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true)
        }
        print("All field completed? ",allfieldsCompleted)
    }
    
    @IBAction func discardChangesPressed(_ sender: Any) {
        //create UIAlert to discard changes
        let alertController = UIAlertController(title: "Discard Changes", message: "Are you sure you would like to discard any changes?", preferredStyle: UIAlertControllerStyle.alert)
        //If confirmed, dismiss view
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
        
    }
    
    
}

