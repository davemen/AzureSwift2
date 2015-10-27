//
//  FirstViewController.swift
//  DevIntersection Sample
//
//  Created by David Mendlen on 9/24/15.
//  Copyright © 2015 David Mendlen. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, DataReadyDelegate,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var myTableView: UITableView!
    
    let mySharedCode = SharedCode()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundview = UIImageView()
        
        backgroundview.image = UIImage(named:"Background")
        // Do any additional setup after loading the view, typically from a nib.
        myTableView.backgroundView = backgroundview
        
        mySharedCode.delegate = self
        mySharedCode.GetSalesPeople()
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        let empname: UILabel? = cell!.viewWithTag(1) as! UILabel?
        let empTitle: UILabel? = cell!.viewWithTag(2) as! UILabel?
        let empImage: UIImageView? = cell!.viewWithTag(3) as! UIImageView?
        
        empname?.text = AllSalesPeople[indexPath.row].SalesPersonName
        empTitle?.text = AllSalesPeople[indexPath.row].SalesPersonTitle
        
        //check for an image
        if AllSalesPeople[indexPath.row].SalesPersonPhoto.characters.count > 0 {
            let url = NSURL(string: AllSalesPeople[indexPath.row].SalesPersonPhoto)
            let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            if data != nil   {
                empImage!.image = UIImage(data: data!)
            }
        }
        

    return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AllSalesPeople.count
    }

    func DataIsReady() {
        NSOperationQueue.mainQueue().addOperationWithBlock(){
        self.myTableView.reloadData()
        }
    }

}
