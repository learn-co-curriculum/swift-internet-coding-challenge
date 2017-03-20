//
//  BookTableViewController.swift
//  swift-internet-coding-challenge
//
//  Created by Sejan Miah on 3/14/17.
//  Copyright © 2017 Sejan Miah. All rights reserved.
//

import UIKit

class BookTableViewController: UITableViewController {
    
    let store = BookDataStore.sharedInstance
    
    @IBOutlet weak var add: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        store.generateBookList { _ in
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.books.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        cell.authorLabel.text = store.books[indexPath.row].author
        cell.titleLabel.text = store.books[indexPath.row].title
        return cell
    }
}

extension BookTableViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "detailBookSegue" {return }
        if let destVC = segue.destination as? DetailBookViewController,
            let indexPath = tableView.indexPathForSelectedRow {
            destVC.book = store.books[indexPath.row]
        }
    }
}

extension BookTableViewController {
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            print(store.books)
//            dump(store.books[indexPath.row])
             let id = store.books[indexPath.row].id
                let idString = String(id)
                print(idString)

                BookClubClient.delete(id: idString, completion: {
                    self.store.generateBookList(completion: {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    })
                })
        }
    }
}

