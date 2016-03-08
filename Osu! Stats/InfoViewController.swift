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
    @IBOutlet weak var lbl_level: UILabel!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadUserInfo()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func LoadUserInfo() {
        API_Functions.getLoginInfo{
            jData in
            
            UserInfo.setUserID(jData[0]["user_id"].stringValue)
            UserInfo.setUsername(jData[0]["username"].stringValue)
            UserInfo.setCount300(jData[0]["count300"].stringValue)
            UserInfo.setCount100(jData[0]["count100"].stringValue)
            UserInfo.setCount50(jData[0]["count50"].stringValue)
            UserInfo.setPlayCount(jData[0]["playcount"].stringValue)
            UserInfo.setRankedScore(jData[0]["ranked_score"].stringValue)
            UserInfo.setTotalScore(jData[0]["total_score"].stringValue)
            UserInfo.setPPRank(jData[0]["pp_rank"].stringValue)
            UserInfo.setLevel(jData[0]["level"].stringValue)
            UserInfo.setPPRaw(jData[0]["pp_raw"].stringValue)
            UserInfo.setAccuracy(jData[0]["accuracy"].stringValue)
            UserInfo.setCountRankSS(jData[0]["count_rank_ss"].stringValue)
            UserInfo.setCountRankS(jData[0]["count_rank_s"].stringValue)
            UserInfo.setCountRankA(jData[0]["count_rank_a"].stringValue)
            UserInfo.setCountry(jData[0]["country"].stringValue)
            UserInfo.setPPCountryRank(jData[0]["pp_country_rank"].stringValue)
            
            dispatch_async(dispatch_get_main_queue()){
                self.lbl_username.text = UserInfo.username
                self.lbl_pprank.text = UserInfo.pp_rank
                self.lbl_level.text = UserInfo.level
            }
        }
    }
    
}
