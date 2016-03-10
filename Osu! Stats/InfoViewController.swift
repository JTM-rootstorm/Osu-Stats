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
        API_Functions.getAPICall("get_user"){
            jData in
            
            if (!jData.isEmpty){
                UserInfo.userID = (jData[0]["user_id"].stringValue)
                UserInfo.username = (jData[0]["username"].stringValue)
                UserInfo.count300 = (jData[0]["count300"].stringValue)
                UserInfo.count100 = (jData[0]["count100"].stringValue)
                UserInfo.count50 = (jData[0]["count50"].stringValue)
                UserInfo.playCount = (jData[0]["playcount"].stringValue)
                UserInfo.ranked_score = (jData[0]["ranked_score"].stringValue)
                UserInfo.total_score = (jData[0]["total_score"].stringValue)
                UserInfo.pp_rank = (jData[0]["pp_rank"].stringValue)
                UserInfo.level = (jData[0]["level"].stringValue)
                UserInfo.pp_raw = (jData[0]["pp_raw"].stringValue)
                UserInfo.accuracy = (jData[0]["accuracy"].stringValue)
                UserInfo.count_rank_ss = (jData[0]["count_rank_ss"].stringValue)
                UserInfo.count_rank_s = (jData[0]["count_rank_s"].stringValue)
                UserInfo.count_rank_a = (jData[0]["count_rank_a"].stringValue)
                UserInfo.country = (jData[0]["country"].stringValue)
                UserInfo.pp_country_rank = (jData[0]["pp_country_rank"].stringValue)
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.lbl_username.text = UserInfo.username
                self.lbl_pprank.text = UserInfo.pp_rank
            }
        }
    }
    
}
