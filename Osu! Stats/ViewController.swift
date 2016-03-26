//
//  ViewController.swift
//  Osu! Stats
//
//  Created by Chancellor Porter on 3/6/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var GoButton: UIButton!
    
    @IBOutlet weak var UsernameEntryBox: UITextField!
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UsernameEntryBox.text = API_Functions.autoPopUsername()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(sender: UIButton){
        API_Functions.getUser().username = (UsernameEntryBox.text!)
        API_Functions.APICall("get_user")
        
        if(API_Functions.validUser){
            performSegueWithIdentifier("toMainStats", sender: self)
        }
        else{
            showAlertButton(sender)
        }
    }
    
    @IBAction func showAlertButton(sender: UIButton){
        let alert = UIAlertController(title: "Error", message: "User does not exist or was typed incorrectly", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

