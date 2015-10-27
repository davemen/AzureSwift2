//
//  DataAccess.swift
//  DevIntersection Sample
//
//  Created by David Mendlen on 10/26/15.
//  Copyright © 2015 David Mendlen. All rights reserved.
//

import UIKit

protocol APIDataReadyDelegate {
    
    // Any Delegate must implement this method
    // The app will call this method when the data is ready
    func APIDataIsReady()
}


class DataAccess: NSObject {
    
    var delegate:APIDataReadyDelegate?
    
    let URLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var theData:NSData = NSData()
    
    func callRemoteAPI(urlPath: String)   {
        
        let myurl:String  = urlPath.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let url = NSURL(string: myurl)
        
        let request:NSURLRequest = NSURLRequest(URL: url!)
        
        let task = URLSession.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            self.theData = data!
            
               if let actualdelegate = self.delegate {
            
            // This means there is an obj assigned to the delegate property
                   actualdelegate.APIDataIsReady()
              }
        }
        task.resume()
        
    }
    
    
    func ConvertToDictionary(data: NSData)->[NSDictionary] {
        var arrayOfDictionaries: [NSDictionary] = [NSDictionary]()
        let result: NSString = NSString(data: data, encoding: NSUTF8StringEncoding)!
        let errorMsg:NSString = "{\"Message\":\"An error has occurred.\"}"
        if result != errorMsg {
            do {
                arrayOfDictionaries = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [NSDictionary]
            } catch
                let error as NSError {
                    // failure
                    print("Fetch failed: \(error.localizedDescription)")
            }
            return arrayOfDictionaries
        }
        return [NSDictionary]()
    }
    
    
}
