//
//  RestaurantsViewController.swift
//  eindOpdrachtMBD2_hmwegelm
//
//  Created by User on 04/04/15.
//  Copyright (c) 2015 hmwegelm2060058. All rights reserved.
//

import UIKit

class RestaurantsViewController: UITableViewController {

    var sendId:String!;
    //var restaurants:[Restaurant] = restaurantData
    var restaurants:NSArray = []
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func loadTableData(){
        let session = NSURLSession.sharedSession()
        var sortBy = "rating"
        
        var currentSortSetting:String
        if (defaults.stringForKey("settings") != nil) {
            currentSortSetting = defaults.stringForKey("settings")!
        }else { currentSortSetting = "0"; }
        
        if (currentSortSetting == "1") {
            sortBy = "distance"
        }

        let url = NSURL(string: "https://api.eet.nu/venues?tags=%2C\(sendId)&sort_by=\(sortBy)")
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    var resultString = NSString(data: theData, encoding: NSUTF8StringEncoding) as String
                    
                    var data: NSData = resultString.dataUsingEncoding(NSUTF8StringEncoding)!
                    var error: NSError?
                    let anyObj: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)!
                    
                    self.restaurants = anyObj["results"] as? NSArray ?? []
                    self.tableView.reloadData()
                })
            }
        })
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableData()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadList(notification: NSNotification){
        //load data here
        self.loadTableData()
//        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return restaurants.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("RestaurantCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        cell.textLabel?.text = self.restaurants[indexPath.row]["name"] as? String
        var cellDescription = self.restaurants[indexPath.row]["rating"] as? Int
        if let showDetail = cellDescription {
            cell.detailTextLabel?.text = "Beoordeling \(cellDescription!)"
        }
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let selectedIndex = self.tableView.indexPathForCell(sender as UITableViewCell)
        let index = selectedIndex?.item
        let givenId: AnyObject = self.restaurants[index!]
        let restaurant = Restaurant(name: givenId["name"] as String, rating: givenId["rating"] as Int, street: givenId["address"]!!["street"]!! as String, postcode: givenId["address"]!!["zipcode"]!! as String, place: givenId["address"]!!["city"]!! as String, phone: givenId["telephone"] as String, long: givenId["geolocation"]!!["longitude"]!! as AnyObject, lat: givenId["geolocation"]!!["latitude"]!! as AnyObject)
        
        var svc = segue.destinationViewController as DetailViewController
        svc.detailInfo = restaurant

    }

}
