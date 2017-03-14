///
/// BookCreator.swift
///

import Then
import UIKit

class BookCreator: UIViewController {
    
    let authorTextField = UITextField()
    let titleTextField = UITextField()
    let publisherTextField = UITextField()
    let urlTextField = UITextField()
    let submit = UIButton()
    
    var views: [UIView] {
        return [authorTextField, titleTextField, publisherTextField, urlTextField, submit]
    }
    
    var missingFields: Bool {
        return authorTextField.text == "" || titleTextField.text == "" || urlTextField.text == ""
    }
    
    var margins: UILayoutGuide {
        return view.layoutMarginsGuide
    }
    
    override func viewDidLoad() {
        title = "Add Book"
        navigationItem.setHidesBackButton(true, animated: false)
        let back = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(returnToRootVC))
        navigationItem.rightBarButtonItem = back
        
        views.forEach { view.addSubview($0) }
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        views.forEach { $0.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true }
        views.forEach { $0.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true }
        
        _ = authorTextField.then {
            $0.topAnchor.constraint(equalTo: margins.topAnchor, constant: 30).isActive = true
            $0.placeholder = "Author"
        }
        
        _ = titleTextField.then {
            $0.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: 20).isActive = true
            $0.placeholder = "Title"
        }
        
        _ = publisherTextField.then {
            $0.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
            $0.placeholder = "Publisher"
        }
        
        _ = urlTextField.then {
            $0.topAnchor.constraint(equalTo: publisherTextField.bottomAnchor, constant: 20).isActive = true
            $0.placeholder = "URL"
        }
        
        _ = submit.then {
            $0.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 20).isActive = true
            $0.setTitle("SUBMIT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.addTarget(self, action: #selector(addBook), for: .touchUpInside)
        }
    }
    
    func returnToRootVC(sender: UIBarButtonItem) {
        var alertController:UIAlertController?
        alertController = UIAlertController(title: "Go back?", message: "Changes won't be saved.", preferredStyle: .alert)
        alertController?.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            _ = self.navigationController?.popToRootViewController(animated: true)
        }))
        alertController?.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController!, animated: true, completion: nil)
    }
    
    func addBook() {
        if missingFields {
            var alertController:UIAlertController?
            alertController = UIAlertController(title: "Fields are missing!", message: nil, preferredStyle: .alert)
            alertController?.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(alertController!, animated: true, completion: nil)
        } else {
            guard
                let author = authorTextField.text,
                let title = titleTextField.text,
                let publisher = publisherTextField.text,
                let url = urlTextField.text
                else { return }
            let params = [
                "author": author,
                "title": title,
                "publisher": publisher,
                "url": url
            ]
            BookClubAPI.shared.addBook(params: params) { book in
                if let book = book { print("Book (\(book.title)) succesfully created.")
            }
            }
        }
    }
}
