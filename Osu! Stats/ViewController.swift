//
//  ViewController.swift
//  Osu! Stats
//
//  Created by Chancellor Porter on 3/6/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userInfo = UserInfo()
    
    @IBOutlet weak var UsernameEntryBox: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: UIButton) {
        var yes = API_Functions.getLoginInfo(UsernameEntryBox.text!, info: self.userInfo)

        print(userInfo.username)
        print(userInfo.pp_rank)
    }
}

