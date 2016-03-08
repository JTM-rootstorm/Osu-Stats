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

class API_Functions: InfoViewController{
    
    class func getLoginInfo(completionHandler: (jData: JSON)->()) ->Bool{
        var output:String = ""
        var URL = "https://osu.ppy.sh/api/get_user?k=b842689a894e7c825998f2f3c490409bdd287af9&u="
        
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
}