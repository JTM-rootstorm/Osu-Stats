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
    private static var user = User()
    static var validUser:Bool = false
    
    class func APICall(api: String) ->Bool{ //, completionHandler: (jData: JSON)->()
        var output:String = ""
        var URL = NSString(string:"https://osu.ppy.sh/api/").stringByAppendingString(api).stringByAppendingString(self.key)
        
        if(user.username.isEmpty){
            output = readFromFile(output)
        }
        else{
            if(!writeToFile()){
                return false
            }
            output = user.username;
        }
        
        URL = URL + output
        
        let session = NSURLSession.sharedSession()
        let loginURL = NSURL(string: URL)!
        
        let semaphore = dispatch_semaphore_create(0)
        
        let task = session.dataTaskWithURL(loginURL){(data, response, error) -> Void in
            let loginData = JSON(data: data!)
            
            if(!loginData.isEmpty){
                if let data = loginData[0].rawString(){
                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    
                    dispatch_async(dispatch_get_global_queue(priority, 0)){
                        self.user = User(json: data)
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
        task.resume()
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
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
    
    class func getUser() ->User{
        return user
    }
}