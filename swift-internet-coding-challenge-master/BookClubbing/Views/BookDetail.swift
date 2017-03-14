///
/// BooksDetail.swift
///

import UIKit

class BookDetail: UIViewController {
    
    let booksClub = BookClubAPI.shared
    
    let authorLabel = UILabel()
    let checkout = UIButton()
    let lastCheckoutOutByLabel = UILabel()
    let publisherLabel = UILabel()
    let titleLabel = UILabel()
    
    var currentlyReading: String {
        return book.lastCheckedOutBy == "" ? "Noone" : book.lastCheckedOutBy
    }
    
    var views: [UIView] {
        return [authorLabel, checkout, lastCheckoutOutByLabel, publisherLabel, titleLabel]
    }
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    var book: Book!
    
    override func viewDidLoad() {
        title = String(book.title)
        
        views.forEach { view.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach { $0.leftAnchor.constraint(equalTo: margins.leftAnchor).isActive = true }

        _ = titleLabel.then {
            $0.font = UIFont(name: "Helvetica", size: 24)
            $0.text = String(book.title.uppercased())
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30).isActive = true
        }
        
        _ = authorLabel.then {
            $0.font = UIFont(name: "Helvetica", size: 18)
            $0.text = String(book.author)
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        }
        
        _ = publisherLabel.then {
            $0.font = UIFont(name: "Helvetica", size: 18)
            $0.text = "Publisher: \(book.publisher)"
            $0.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10).isActive = true
        }
        
        _ = lastCheckoutOutByLabel.then {
            $0.font = UIFont(name: "Helvetica", size: 18)
            $0.text = "\(currentlyReading) is reading."
            $0.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 10).isActive = true
        }
        
        _ = checkout.then {
            $0.setTitle("CHECKOUT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.addTarget(self, action: #selector(checkoutTapped), for: .touchUpInside)
        }
    }
    
    func checkoutTapped(sender: UIButton!) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Checkout", message: "Enter your name", preferredStyle: .alert)
        alertController?.addTextField()
        
        let action = UIAlertAction(title: "Submit", style: .default, handler: {[weak self] _ in
            guard let name = alertController?.textFields?[0].text else { return }
            self?.checkoutBook(for: name)
        })
        
        alertController?.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    private func checkoutBook(for name: String) {
        booksClub.checkoutBook(id: book.id, for: name) { book in
            guard let book = book else { return }
            Store.shared.update(book)
        }
    }
}
