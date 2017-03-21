//
//  BookListTableViewController.swift
//  BookClub
//
//  Created by ac on 3/14/17.
//  Copyright © 2017 amitc. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController {

    let singleton = Catalog.sharedBookList
    let bookApi = BookClubAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //getBooks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("In BookListTableViewController:viewWillAppear")
     
        bookApi.getBooks(id: "0") { responseJson in
        
            guard let unwrappedJson = responseJson else { print("Invalid Json data"); return  }
        
            //print("unwrappedJson:\(unwrappedJson)")
            for bookData in unwrappedJson {
                let book = Book( dict: bookData)
                self.singleton.bookList.append(book)
                print("id:\(book.id) title:\(book.title)")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return singleton.bookList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookListCell", for: indexPath) as! BookListCell

        // Configure the cell...
        cell.bookTitle.text = singleton.bookList[indexPath.row].title
        cell.bookAuthor.text = singleton.bookList[indexPath.row].author
                
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //BookDetails
        if segue.identifier == "bookDetailsSegue" {
            let selectedRow = tableView.indexPathForSelectedRow
            let destVC = segue.destination as? BookDetailsViewController
            destVC?.bookIndex = selectedRow?.row
        
        }
        //AddBook
        if segue.identifier == "addBookSegue" {
            let _ = segue.destination as? AddBookViewController
            
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
