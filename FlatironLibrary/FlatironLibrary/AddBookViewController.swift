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
    
    weak var delegate: ReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Book"
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func addBook() {
        //Force unwraping is used here due to the fact that any nil
        
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
            reloadView()
        } else {
            //create UI Alert
            let alertController = UIAlertController(title: "Incomplete", message: "Please complete all fields before submitting", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alertController.addAction(okAction)
        }
        print("All field completed? ",allfieldsCompleted)
    }
    
    func reloadView() {
        delegate?.reloadTableView()
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// TODO: FIx the table so that it reloads with every POST request
protocol ReloadDelegate: class {
    func reloadTableView()
}
