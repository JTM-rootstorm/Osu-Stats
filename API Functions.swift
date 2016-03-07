//
//  API Functions.swift
//  Osu! Stats
//
//  Created by erich on 7/8/15.
//  Modified by Michael Justman on 3/7/16
//  Copyright © 2016 Chancellor Porter. All rights reserved.
//
// Official API documentation  https://github.com/ppy/osu-api/wiki


//My Osu API Access Key is b842689a894e7c825998f2f3c490409bdd287af9&


//   Example of how the Access URL is used in combination with Variables
//https://osu.ppy.sh/api/get_user?k=b842689a894e7c825998f2f3c490409bdd287af9&u=lilchancep

import Foundation

class API_Functions{
    
    class func getLoginInfo( userName:String, info:UserInfo) ->Bool{
        var output:String = ""
        var URL = "https://osu.ppy.sh/api/get_user?k=b842689a894e7c825998f2f3c490409bdd287af9&u="
        
        if(userName.isEmpty){
            let path = "./Username.txt"
            let readFile = (try? NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)) as? String
            if let fileContents = readFile{
                output = fileContents as String
            }
            else{
                print("Error reading file contents at " + path)
                return false
            }
            
            if (output.isEmpty){
                return false
            }
        }
        else{
            let path = "./Username.txt"
            var error = NSError(domain: "somedomain", code: 123, userInfo: nil)
            let written:Bool
            do{
                try userName.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding)
                written = true
            }
            catch let error1 as NSError{
                error = error1
                written = false
            }
            if written{
                
            }
            else{
                print("There was a problem: \(error)")
                return false
            }
            
            output = userName;
        }
        
        URL = URL + output
        
        let session = NSURLSession.sharedSession()
        let loginURL = NSURL(string: URL)
        
        let task = session.dataTaskWithURL(loginURL!){
            (data, response, error) -> Void in
            
            if error != nil{
                print(error?.localizedDescription)
            }
            else{
                var error:NSError?
                
                var loginData = JSON(data: data!)
                
                let usr: String = loginData["username"].stringValue
                let pp_rank: String = loginData["pp_raw"].stringValue
                
                info.pp_rank = pp_rank
                info.username = usr
            }
        }
        task.resume()
        
        return true
    }
}