//
//  UserInfo.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/7/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import Foundation

class UserInfo{
    static var username = "", pp_rank = ""
    
    class func setUsername(usr:String){
        username = usr
    }
    
    class func setPPRank(pp:String){
        pp_rank = pp
    }
}