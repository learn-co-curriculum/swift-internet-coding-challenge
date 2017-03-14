///
/// BooksVC.swift
///

import UIKit

class BooksVC: UITableViewController {
    
    let booksClub = BookClubAPI.shared
    let store = Store.shared
    var books: [Book] {
        return store.books
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(BookCell.self, forCellReuseIdentifier: BookCell.reuseID)
        layoutNavigationBar()
        if store.books.isEmpty { fillStore() }
    }
    
    func layoutNavigationBar() {
        title = "BookShelf"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBook))
        navigationItem.leftBarButtonItem = add
    }
    
    func addBook(sender: UIBarButtonItem) {
        let vc = BookCreator()
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    func fillStore() {
        booksClub.getBooks { bookResults in
            self.store.books = bookResults
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Methods
extension BooksVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookCell.reuseID, for: indexPath) as! BookCell
        cell.book = books[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookDetail = BookDetail()
        bookDetail.book = books[indexPath.row]
        self.navigationController?.pushViewController(bookDetail, animated: true)
    }
}
