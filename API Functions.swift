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
import APIPod
import SwiftyJSON


class API_Functions{
    
    private static var key = APIKey.getKey()
    private static var user = User()
    static var validUser:Bool = false
    
    class func getUserAPI() ->Bool{ //, completionHandler: (jData: JSON)->()
        
        //build url to use in API call
        var URL = NSString(string:"https://osu.ppy.sh/api/get_user").stringByAppendingString(self.key)
        
        if(user.username.isEmpty){
            return false
        }
        else{
            if(!writeToFile()){
                return false
            }
        }
        
        URL = URL + user.username.stringByReplacingOccurrencesOfString(" ", withString: "");
        
        let semaphore = dispatch_semaphore_create(0)
        
        APICall(URL){
            jData in
            
            if(!jData.isEmpty){
                if let data = jData[0].rawString(){
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    
                    dispatch_async(dispatch_get_global_queue(priority, 0)){
                        self.user = User(json: data)
                        userToJSONFile()
                        validUser = true
                        dispatch_semaphore_signal(semaphore)
                    }
                }
            }
            else{
                validUser = false
                dispatch_semaphore_signal(semaphore)
            }
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return true
    }
    
    class func getUserBest() ->Bool{
        var URL = NSString(string:"https://osu.ppy.sh/api/get_user_best").stringByAppendingString(self.key)
        URL = URL + user.username.stringByReplacingOccurrencesOfString(" ", withString: "");
        
        let semaphore = dispatch_semaphore_create(0)
        
        APICall(URL){
            jData in
            
            if(!jData.isEmpty){
                self.user.best = jData.arrayObject!
                dispatch_semaphore_signal(semaphore)
            }
            else{
                dispatch_semaphore_signal(semaphore)
            }
        }
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return true
    }
    
    class func autoPopUsername() -> String{
        var username:String = ""
        
        username = readFromFile(username)
        
        return username
    }
    
    private class func APICall(URL:String, completionHandler: (jData: JSON)->()){
        let session = NSURLSession.sharedSession()
        let loginURL = NSURL(string: URL)!
        
        let task = session.dataTaskWithURL(loginURL){(data, response, error) -> Void in
            let loginData = JSON(data: data!)
            
            completionHandler(jData: loginData)
        }
        task.resume()
    }
    
    /** read username from text file for autopopulation of username field on next launch */
    private class func readFromFile(out:String) -> String{
        var output = out
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
    
    /** write username to text file for autopopulation of username field on next launch */
    private class func writeToFile() -> Bool{
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let writePath = NSString(string: path).stringByAppendingPathComponent("Username.txt")
        var error = NSError(domain: "somedomain", code: 123, userInfo: nil)
        let written:Bool
        do{
            try user.username.writeToFile(writePath, atomically: true, encoding: NSUTF8StringEncoding)
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
    
    /** output user data to JSON file as a cache so we don't have to call the API every time */
    class func userToJSONFile() ->Bool{
        let userFile = NSString(string: user.username).stringByAppendingString(".JSON")
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let writePath = NSString(string: path).stringByAppendingPathComponent(userFile)
        
        do{
            try user.toJsonString().writeToFile(writePath, atomically: true, encoding: NSUTF8StringEncoding)
            print(writePath)
        }
        catch let error1 as NSError{
            print("Error: \(error1)")
            return false
        }
        
        return true
    }
    
    class func getUser() ->User{
        return user
    }
}