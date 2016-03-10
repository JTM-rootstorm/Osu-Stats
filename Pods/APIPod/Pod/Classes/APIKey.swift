//
//  APIFramework.swift
//  APIFramework
//
//  Created by Michael Justman on 3/9/16.
//  Copyright © 2016 Michael Justman. All rights reserved.
//

import Foundation

public class APIKey{
    private static let key = "?k=b842689a894e7c825998f2f3c490409bdd287af9&u="
    
    public init (){
        print("API Key framework loaded")
    }
    
    public class func getKey() ->String{
        return self.key
    }
}