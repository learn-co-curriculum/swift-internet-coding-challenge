//
//  BookCellTableViewCell.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import UIKit

class BookCellTableViewCell: UITableViewCell {

    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
