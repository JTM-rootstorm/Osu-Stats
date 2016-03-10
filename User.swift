//
//  User.swift
//  Osu! Stats
//
//  Created by Michael Justman on 3/10/16.
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//

import Foundation
import EVReflection

class User: EVObject{
    var user_id: String = ""
    var username: String = ""
    var count300: String = ""
    var count100: String = ""
    var count50: String = ""
    var playcount: String = ""
    var ranked_score: String = ""
    var total_score: String = ""
    var pp_rank: String = ""
    var level: String = ""
    var pp_raw: String = ""
    var accuracy: String = ""
    var count_rank_ss: String = ""
    var count_rank_s: String = ""
    var count_rank_a: String = ""
    var country: String = ""
    var pp_country_rank: String = ""
    var events: [String] = []
}