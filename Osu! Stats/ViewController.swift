//
//  ViewController.swift
//  Osu! Stats
//
//  Created by Chancellor Porter on 3/6/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var UsernameEntryBox: UITextField!
    @IBOutlet weak var GoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: UIButton){
        UserInfo.setUsername(UsernameEntryBox.text!)
    }
}

