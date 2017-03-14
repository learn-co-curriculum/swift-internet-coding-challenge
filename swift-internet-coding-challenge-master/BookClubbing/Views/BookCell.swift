///
/// BookCell.swift
///

import Then
import UIKit

class BookCell: UITableViewCell {
    
    let author: UILabel
    let title: UILabel
 
    var book: Book? {
        didSet {
            guard let book = book else { return }
            author.text = book.author
            title.text = book.title
        }
    }
    
    static let reuseID = "book"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        author = UILabel()
        title = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        _ = author.then {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        }
        
        _ = title.then {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: author.bottomAnchor).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
