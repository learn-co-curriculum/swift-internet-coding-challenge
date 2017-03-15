//
//  LibraryTableViewController.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/14/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    let store = LibraryDataStore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Store in VC holds \(store.books.count) books")
        store.createBooks {
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        cell.bookTitle.text = store.books[indexPath.row].title
        cell.bookSubtitle.text = store.books[indexPath.row].author
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showDetail" { return }
        if let dest = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            print(store.books[indexPath.row].description)
            dest.book = store.books[indexPath.row]
        }
    }
    

}
