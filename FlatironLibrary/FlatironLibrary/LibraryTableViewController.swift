//
//  LibraryTableViewController.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/14/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
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
        createBooks {
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
            print("The book array holds \(self.books.count) books")
            completion()
        }
    }
    
    //Added swipe to delete funtionality
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = books[indexPath.row].bookID
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            LibraryAPIManager.deleteBook(bookID: id, completion: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
    }
    
}
