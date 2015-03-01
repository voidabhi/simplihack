//
//  CallingServer.swift
//  SimpliHack
//
//  Created by Alvin Varghese on 28/Feb/15.
//  Copyright (c) 2015 SimpliLearn. All rights reserved.
//

import UIKit


protocol ServerRequet
{
   func finalResult(username : String, password : String)
}

class CallingServer: NSObject
{
    
    //MARK: - Delegate Instance

    var delegate : ServerRequet!
    
    //MARK: - Creating sharedInstance
    
    class var sharedInstance : CallingServer
    {
        struct Static
        {
            static var instance : CallingServer?
            static var token : dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token, {
            
            Static.instance = CallingServer()
            
        })
        
        return Static.instance!
    }
    
    //MARK: - Request to server
    
    func startFetching(tempString : String)
    {
        
        NSURLConnection(request: NSURLRequest(URL: NSURL(string: tempString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!), delegate: self, startImmediately: true)

    }
    
    //MARK: - NSURLConnection Delegate methods
    
    
    var responseData : NSMutableData = NSMutableData()
    var totalFileSize : Int = Int()
    var dataBytes : Int  = Int()
    
    func connection(connection: NSURLConnection!, didReceiveResponse response: NSURLResponse!)
    {
        self.responseData.length = 0
        totalFileSize = ( Int) (response.expectedContentLength)
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!)
    {
        dataBytes = data.length
        self.responseData.appendData(data)
        
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        if let responseDatas = responseData as NSData? {
            
            if let jsonResult : NSDictionary = NSJSONSerialization.JSONObjectWithData(responseDatas, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary?
            {
                
                if let password = jsonResult.objectForKey("password") as? String
                {
                    if let username = jsonResult.objectForKey("username") as? String
                    {
                        self.passingTheValue(username, password: password)
                    }
                }
            }
            else
            {
                // Data not getting - error
            }
        }
        else
        {
            // Server down
        }
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!)
    {
        Utilities.sharedInstance.alertThis("Error :(", message: "\(error.localizedDescription)")
    }
    
    
    func passingTheValue(username : String, password : String)
    {
        self.delegate.finalResult(username, password: password)
    }
    
    
    
    
}
