//
//  API Functions.swift
//  Osu! Stats
//
//  Created by erich on 7/8/15.
//  Heavily Modified by Michael Justman on 3/7/16 - 3/9/16
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//
// Official API documentation  https://github.com/ppy/osu-api/wiki


//   Example of how the Access URL is used in combination with Variables
//https://osu.ppy.sh/api/get_user?k=API-KEY&u=lilchancep

import Foundation
import APIFramework

class API_Functions{
    
    private static var key = APIKey.getKey()
    
    class func getAPICall(api: String, completionHandler: (jData: JSON)->()) ->Bool{
        var output:String = ""
        var URL = NSString(string:"https://osu.ppy.sh/api/").stringByAppendingString(api).stringByAppendingString(self.key)
        
        if(UserInfo.username.isEmpty){
            output = readFromFile(output)
        }
        else{
            if(!writeToFile()){
                return false
            }
            
            output = UserInfo.username;
        }
        
        URL = URL + output
        
        let session = NSURLSession.sharedSession()
        let loginURL = NSURL(string: URL)!
        
        let task = session.dataTaskWithURL(loginURL){(data, response, error) -> Void in
            let loginData = JSON(data: data!)
            
            completionHandler(jData: loginData)
        }
        task.resume()
        
        return true
    }
    
    class func autoPopUsername() -> String{
        var username:String = ""
        
        username = readFromFile(username)
        
        return username
    }
    
    private class func readFromFile(var output:String) -> String{
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let readPath = NSString(string: path).stringByAppendingPathComponent("Username.txt")
        let readFile = (try? NSString(contentsOfFile: readPath, encoding: NSUTF8StringEncoding)) as? String
        if let fileContents = readFile{
            output = fileContents as String
        }
        else{
            //print("Error reading file contents at " + readPath)
        }
        
        if (output.isEmpty){
            print("File is empty")
        }
        
        return output
    }
    
    private class func writeToFile() -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let writePath = NSString(string: path).stringByAppendingPathComponent("Username.txt")
        var error = NSError(domain: "somedomain", code: 123, userInfo: nil)
        let written:Bool
        do{
            try UserInfo.username.writeToFile(writePath, atomically: true, encoding: NSUTF8StringEncoding)
            written = true
        }
        catch let error1 as NSError{
            error = error1
            written = false
        }
        if (!written) {
            print("There was a problem: \(error)")
            return false
        }
        
        return true
    }
    
    class func LoadUserInfo(api_call: String) -> Bool{
        
        var validUser:Bool = false
        
        getAPICall(api_call){
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
                validUser = true
            }
            else{
                validUser = false
            }
        }
        
        return validUser
    }
}