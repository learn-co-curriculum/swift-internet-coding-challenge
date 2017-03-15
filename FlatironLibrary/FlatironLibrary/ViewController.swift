//
//  ViewController.swift
//  FlatironLibrary
//
//  Created by Kaypree Hodges on 3/13/17.
//  Copyright © 2017 Kaypree Hodges. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LibraryAPIManager.getBooks { (dict) in
            print(dict)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

