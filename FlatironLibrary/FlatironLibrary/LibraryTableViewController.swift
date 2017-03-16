//
//  LibraryTableViewController.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/14/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController, ReloadDelegate {
    
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createBooks {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        cell.bookTitle.text = books[indexPath.row].title
        cell.bookSubtitle.text = books[indexPath.row].author
        return cell
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showDetail" { return }
        if let dest = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            print(books[indexPath.row].description)
            dest.book = books[indexPath.row]
        }
    }
    
    func reloadTableView() {
        self.tableView.reloadData()
    }
    
    func createBooks(completion: @escaping () -> ()) {
        LibraryAPIManager.getBooks { (JSONObjects) in
            self.books.removeAll()
            for object in JSONObjects {
                let book = Book(dict: object)
                self.books.append(book)
            }
            print("The DataStore's book array holds \(self.books.count) books")
            completion()
        }
    }
    
    
    
    
    
    
    
    
}
