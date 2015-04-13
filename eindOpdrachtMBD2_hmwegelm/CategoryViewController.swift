//
//  CategoryViewController.swift
//  eindOpdrachtMBD2_hmwegelm
//
//  Created by User on 04/04/15.
//  Copyright (c) 2015 hmwegelm2060058. All rights reserved.
//

import UIKit

class CategoryViewController: UITableViewController {
    var categorys:NSArray = []
    
    func loadTableData(){
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://api.eet.nu/tags")
        let task = session.dataTaskWithURL(url!, completionHandler: {(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
            if let theData = data {
                dispatch_async(dispatch_get_main_queue(), {
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    var resultString = NSString(data: theData, encoding: NSUTF8StringEncoding) as String

                    var data: NSData = resultString.dataUsingEncoding(NSUTF8StringEncoding)!
                    var error: NSError?
                    let anyObj: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)!
                    
                    self.categorys = anyObj["results"] as? NSArray ?? []
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return self.categorys.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as UITableViewCell
        // Configure the cell...
        cell.textLabel?.text = self.categorys[indexPath.row]["name"] as? String

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
        let givenId = self.categorys[index!]["id"] as? String
        var svc = segue.destinationViewController as RestaurantsViewController
        svc.sendId = givenId

    }
    
    
}
