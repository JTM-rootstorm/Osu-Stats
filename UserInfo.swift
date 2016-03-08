//
//  UserInfo.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/7/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import Foundation

class UserInfo{
    static var username = "lilchancep", pp_rank = "p"
    
    class func setUsername(usr:String){
        username = usr
    }
    
    class func getUsername() -> String{
        return username
    }
    
    class func setPPRank(pp:String){
        pp_rank = pp
    }
    
    class func getPPRank() -> String{
        return pp_rank
    }
}