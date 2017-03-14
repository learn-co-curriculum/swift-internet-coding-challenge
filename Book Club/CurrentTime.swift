//
//  CurrentTime.swift
//  Book Club
//
//  Created by Benjamin Bernstein on 3/14/17.
//  Copyright © 2017 Burning Flowers. All rights reserved.
//

import Foundation

func currentTime() -> String {
    let date = Date()
    let formatter = DateFormatter()
    
    formatter.dateFormat = "H:MM, MMMM dd"
    return formatter.string(from: date)
}

