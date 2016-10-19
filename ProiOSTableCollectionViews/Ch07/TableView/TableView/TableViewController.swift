//
//  TableViewController.swift
//  TableView
//
//  Created by Tim on 18/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var tableData: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add edit button to the nav bar
        let editButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "didTapEditButton")

        self.navigationItem.leftBarButtonItem = editButton
        
        // Setup table
        tableView.registerNib(UINib(nibName: "TableCustomCell", bundle: nil), forCellReuseIdentifier: "MyCustomCell")
        
        tableData = ["Eins", "Zwei", "Drei", "Vier", "Fünf", "Sechs", "Sieben", "Acht", "Neun", "Zehn", "Elf", "Zwolf", "Dreizehn", "Vierzehn", "Fünfzehn"]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCustomCell", forIndexPath: indexPath)

        let text: String  = tableData[indexPath.row]
        
        // Configure the cell...
        if let textLabel = cell.contentView.viewWithTag(1000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        if let textLabel = cell.contentView.viewWithTag(2000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        if let textLabel = cell.contentView.viewWithTag(3000) as? UILabel {
            textLabel.text = text
            textLabel.sizeToFit()
        }

        return cell
    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // calculate height of row here
        return 50
    }
    
    // Override to support conditional editing of the table voverride iew.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        if editingStyle == .Delete {

            tableData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {

            tableData.append("New item")
            tableView.reloadData()
            
        }
    }

    override func tableView(tableView: UITableView, willBeginEditingRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        let contentViewSize = cell?.contentView.frame.size.width
        
        print("size = \(contentViewSize)")
        
    }
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

        let rowToMove = tableData[fromIndexPath.row]
        tableData.removeAtIndex(fromIndexPath.row)
        tableData.insert(rowToMove, atIndex: toIndexPath.row)
        tableView.reloadData()
        
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

}

extension TableViewController {
    
    @IBAction func didTapEditButton() {
        tableView.setEditing(!tableView.editing, animated: true)
    }
    
}
