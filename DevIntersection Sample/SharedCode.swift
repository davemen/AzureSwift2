//
//  SharedCode.swift
//  DevIntersection Sample
//
//  Created by David Mendlen on 9/24/15.
//  Copyright © 2015 David Mendlen. All rights reserved.
//

import UIKit


protocol DataReadyDelegate {
    
    // Any Delegate must implement this method
    // The app will call this method when the data is ready
    func DataIsReady()
}


let MyDataAccess:DataAccess = DataAccess()
var AllSalesPeople: [Person] = [Person]()


class SharedCode: NSObject, APIDataReadyDelegate{
    
    var delegate:DataReadyDelegate?
    
    func GetSalesPeople()  {
        
        //Call the Get data API
        let url = "http://disample2.azurewebsites.net/api/sales"
       MyDataAccess.delegate = self
        
        
        MyDataAccess.callRemoteAPI(url)
        
    }
    
    func APIDataIsReady() { //convert the JSON object to the NS Dictionary - and write that to the SalesPerson class
        
        SaveThePeople()
    }
    
    func SaveThePeople() {
        var People: [NSDictionary] = [NSDictionary]()
        
       People = MyDataAccess.ConvertToDictionary(MyDataAccess.theData)

        for eachPerson in People {
            
            let l:Person = Person()
            
            //PersonName
            if let thevalue = eachPerson.valueForKey("PersonName") as? String {
                l.SalesPersonName = thevalue
            }
            
            //PersonTitle
            if let thevalue = eachPerson.valueForKey("PersonTitle") as? String {
                l.SalesPersonTitle = thevalue
            }
            
            //PersonPhoto
            if let thevalue = eachPerson.valueForKey("ImageURL") as? String {
                l.SalesPersonPhoto = thevalue
            }
                
            //CurrentSales
            if let thevalue = eachPerson.valueForKey("CurrentSales") as? Int {
                l.CurrentSales = thevalue
            }
            //Quota Sales
            if let thevalue = eachPerson.valueForKey("CurrentQuota") as? Int {
                l.SalesQuota = thevalue
            }
            AllSalesPeople.append(l)
        }
        
        if let actualdelegate = self.delegate {
            
            // This means there is an obj assigned to the delegate property
            actualdelegate.DataIsReady()
        }
        
    }
}


