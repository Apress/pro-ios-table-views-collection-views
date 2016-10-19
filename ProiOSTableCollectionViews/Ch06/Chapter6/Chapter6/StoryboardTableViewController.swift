//
//  StoryboardTableViewController.swift
//  Chapter6
//
//  Created by Tim on 27/09/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class StoryboardTableViewController: UITableViewController {

    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0)
        
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
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = tableData[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) 
        
        switch cellIdentifier {
            
        case "BasicCellIdentifier" :
            cell.textLabel!.text = "Basic cell"
            
        case "RightDetailCellIdentifier":
            cell.textLabel!.text = "Right detail cell"
            cell.detailTextLabel!.text = "Detail text label"
            
        case "LeftDetailCellIdentifier" :
            cell.textLabel!.text = "Left detail cell"
            cell.detailTextLabel!.text = "Detail text label"
            
        case "SubtitleCellIdentifier" :
            cell.textLabel!.text = "Subtitle cell"
            cell.detailTextLabel!.text = "Detail text label"
            
        default :  // Handles CustomCellIdentifier by process of elimination
            print("The default custom cell type is empty and has no controls")
            
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

extension StoryboardTableViewController {
    
    func setupTable() {
        
        tableData.append("BasicCellIdentifier")
        tableData.append("RightDetailCellIdentifier")
        tableData.append("LeftDetailCellIdentifier")
        tableData.append("SubtitleCellIdentifier")
        tableData.append("CustomCellIdentifier")
        
    }
    
}
