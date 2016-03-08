//
//  InfoViewController.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/7/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
        
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_pprank: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadUserInfo()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func LoadUserInfo() {
        print("function called")
        API_Functions.getLoginInfo{
            jData in
            //print("VC: \(jData)")
            
            UserInfo.setUsername(jData[0]["username"].stringValue)
            UserInfo.setPPRank(jData[0]["pp_rank"].stringValue)
            
            dispatch_async(dispatch_get_main_queue()){
                self.lbl_username.text = UserInfo.getUsername()
                self.lbl_pprank.text = UserInfo.getPPRank()
            }
        }
    }
}
