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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
<<<<<<< HEAD
=======
    
    @IBAction func Login(sender: UIButton) {
        API_Functions.getLoginInfo(UsernameEntryBox.text!, info: self.userInfo)

        print(userInfo.username)
        print(userInfo.pp_rank)
    }
>>>>>>> lilchancep/master
}

