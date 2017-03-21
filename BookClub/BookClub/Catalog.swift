//
//  Catalog.swift
//  BookClub
//
//  Created by ac on 3/14/17.
//  Copyright © 2017 amitc. All rights reserved.
//

import Foundation

final class Catalog {
    var bookList:[Book] = []
    static let sharedBookList = Catalog()
    private init() {  }
}
