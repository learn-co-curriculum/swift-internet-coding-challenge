//
//  BookDetailsViewController.swift
//  BookClub
//
//  Created by ac on 3/14/17.
//  Copyright © 2017 amitc. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookDetailsLabel: UILabel!
    @IBOutlet weak var bookUrlLabel: UILabel!
    
    @IBOutlet weak var checkOutOutlet: UIButton!
    @IBOutlet weak var updateOutlet: UIButton!
    @IBOutlet weak var deleteOutlet: UIButton!
    
    
    var bookIndex:Int?
    let singleton = Catalog.sharedBookList
    let bookApi = BookClubAPI()
    
    
    @IBAction func checkOutAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Checkout", message: "Please enter your name", preferredStyle: .alert)
        //add text field
        alertController.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        //action - called when button pressed
        var userName = UITextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {action in
            userName = (alertController.textFields?[0])! as UITextField
            let lastCheckedOutBy = userName.text! + " @ \(Date()) "
            
            /*self.singleton.bookList[self.bookIndex!].lastCheckedOutBy = userName.text! + "\(Date())"
            self.singleton.bookList[self.bookIndex!].lastCheckedOut = true */
            
            print("checkOutAction:lastCheckedOutBy:\(lastCheckedOutBy)")
                //\nsingleton:\(self.singleton.bookList[self.bookIndex!].lastCheckedOutBy!)")
            
            let paramDict = ["lastcheckedoutby":lastCheckedOutBy, "lastcheckedout":true ] as [String : Any]
            self.bookApi.updateBook(id:String(self.singleton.bookList[self.bookIndex!].id), dict: paramDict /*["lastcheckedoutby":"\(userName.text!)"]*/ ) { responseJson in
                
                let book = Book( dict: responseJson[0])
                self.singleton.bookList[self.bookIndex!] = book
                print("In checkOutAction: id:\(book.id) title:\(book.title)")

                self.viewDidAppear(true)
            }
        })
        
        //add action
        alertController.addAction(submitAction)
        
        //display alert
        self.present(alertController, animated: true, completion: nil)
        
        
    } //func checkOutAction
    
    
    @IBAction func updateAction(_ sender: UIButton) {
        let updateAlertController = UIAlertController(title: "Update", message: "Please edit the fields to be changed", preferredStyle: .alert)
        //add text field
        updateAlertController.addTextField { (textField) in
            textField.text = self.singleton.bookList[self.bookIndex!].title
        }
        updateAlertController.addTextField { (textField) in
            textField.text = self.singleton.bookList[self.bookIndex!].author
        }
        updateAlertController.addTextField { (textField) in
            textField.text = self.singleton.bookList[self.bookIndex!].publisher
        }
        updateAlertController.addTextField { (textField) in
            textField.text = self.singleton.bookList[self.bookIndex!].url
        }
       /* updateAlertController.addTextField { (textField) in
            textField.text = self.singleton.bookList[self.bookIndex!].lastCheckedOutBy
        } */
        
        //action - called when button pressed
        //var userName = UITextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default, handler: {action in
            let title = (updateAlertController.textFields?[0])! as UITextField
            let author = (updateAlertController.textFields?[1])! as UITextField
            let publisher = (updateAlertController.textFields?[2])! as UITextField
            let url = (updateAlertController.textFields?[3])! as UITextField
            //let lastCheckedOutBy = (updateAlertController.textFields?[4])! as UITextField

            //title.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            
            /*self.singleton.bookList[self.bookIndex!].lastCheckedOutBy = userName.text! + "\(Date())"
             self.singleton.bookList[self.bookIndex!].lastCheckedOut = true */
            
            print("updateAction:title:\(title) author:\(author)")
            //\nsingleton:\(self.singleton.bookList[self.bookIndex!].lastCheckedOutBy!)")
            
            let paramDict = ["title":title.text!,"author":author.text!,"publisher":publisher.text!, "url":url.text!] as [String : Any]
            
            self.bookApi.updateBook(id:String(self.singleton.bookList[self.bookIndex!].id), dict: paramDict) { responseJson in
            
                let book = Book( dict: responseJson[0])
                self.singleton.bookList[self.bookIndex!] = book
                print("In updateAction: id:\(book.id) title:\(book.title)")

                self.viewDidAppear(true)
            }
        })
        
        
        
        
        
        //updateAlertController
        updateAlertController.addAction(submitAction)
        
        //display alert
        self.present(updateAlertController, animated: true, completion: nil)
        

        
    }
    
    @IBAction func deleteAction(_ sender: UIButton) {
        
        bookApi.deleteBook(id: String(self.singleton.bookList[bookIndex!].id) ) {
            self.bookDetailsLabel.text = self.bookDetailsLabel.text! + "\n\n\n   ***THIS BOOK HAS BEEN DELETED***  \n"
            self.checkOutOutlet.isEnabled = false
            self.updateOutlet.isEnabled = false
            self.deleteOutlet.isEnabled = false
        }
        
    }
    
    
    
    //override func viewDidLoad() {
    override func viewDidAppear(_ animated: Bool) {
        //super.viewDidLoad()
        super.viewDidAppear(animated)
        print("In BookDetailsViewController:viewDidAppear:bookIndex=\(bookIndex)")
        var bookDetails:String
        // Do any additional setup after loading the view, typically from a nib.
        
        if let bookIndex = bookIndex {
            /*bookApi.getBooks(id: String(self.singleton.bookList[self.bookIndex!].id)) { responseJson in
            
            guard let unwrappedJson = responseJson else { print("Invalid Json data"); return  }
            
            //print("unwrappedJson:\(unwrappedJson)")
            //for bookData in unwrappedJson {
                let book = Book( dict: unwrappedJson[0])
                self.singleton.bookList[bookIndex] = book
                print("id:\(book.id) title:\(book.title)")
            //}
                /*DispatchQueue.main.async {
                    self.tableView.reloadData()
                }*/
        
            } */

            bookTitleLabel.text = singleton.bookList[bookIndex].title
            bookAuthorLabel.text = singleton.bookList[bookIndex].author
            bookUrlLabel.text = singleton.bookList[bookIndex].url
            
            bookDetails = "Publisher: " + singleton.bookList[bookIndex].publisher
            if let lastCheckedOutBy = singleton.bookList[bookIndex].lastCheckedOutBy {
               bookDetails += "\n\nLast Checked Out: \n" + lastCheckedOutBy
                
                /*if let lastCheckedOut = singleton.bookList[bookIndex].lastCheckedOut {
                    bookDetails  += " @ " + lastCheckedOut
                }*/
            }
            
            bookDetailsLabel.text = bookDetails
        }
        
    }
    

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

