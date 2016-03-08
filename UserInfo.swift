//
//  UserInfo.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/7/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import Foundation

class UserInfo{
    static var userID = "", username = "", count300 = "", count100 = "", count50 = "", playCount = "", ranked_score = "", total_score = ""
    static var pp_rank = "", level = "", pp_raw = "", accuracy = "", count_rank_ss = "", count_rank_s = "", count_rank_a = "", country = "", pp_country_rank = ""
    
    class func setUserID(usr:String){
        userID = usr
    }
    
    class func setUsername(usr:String){
        username = usr
    }
    
    class func setCount300(count:String){
        count300 = count
    }
    
    class func setCount100(count:String){
        count100 = count
    }
    
    class func setCount50(count:String){
        count50 = count
    }
    
    class func setPlayCount(count:String){
        playCount = count
    }
    
    class func setRankedScore(score:String){
        ranked_score = score
    }
    
    class func setTotalScore(score:String){
        total_score = score
    }
    
    class func setPPRank(pp:String){
        pp_rank = pp
    }
    
    class func setLevel(level:String){
        self.level = level
    }
    
    class func setPPRaw(pp:String){
        pp_raw = pp
    }
    
    class func setAccuracy(acc:String){
        accuracy = acc
    }
    
    class func setCountRankSS(count:String){
        count_rank_ss = count
    }
    
    class func setCountRankS(count:String){
        count_rank_s = count
    }
    
    class func setCountRankA(count:String){
        count_rank_a = count
    }
    
    class func setCountry(country:String){
        self.country = country
    }
    
    class func setPPCountryRank(pp:String){
        pp_country_rank = pp
    }
}