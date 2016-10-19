//
//  ViewController.swift
//  EditingApp
//
//  Created by Tim on 01/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Row insertion"
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        for index in 0...10 {
            tableData.append("Row \(index)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        if indexPath.row == tableData.count {
            cell.textLabel?.text = "Add new row"
            cell.textLabel?.textColor = UIColor.darkGrayColor()
        } else {
            cell.textLabel?.text = tableData[indexPath.row]
        }

        return cell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    if (indexPath.row == tableData.count) {
        
        // put table into edit mode
        tableView.setEditing(true, animated: true)
        
    } else {
        
        // Handle "normal" selection
        
    }
    
}
    
    override func setEditing(editing: Bool, animated: Bool) {
        tableView.setEditing(!tableView.editing, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        if tableView.editing {
            if (indexPath.row == tableData.count) {
                return UITableViewCellEditingStyle.Insert;
            } else {
                return UITableViewCellEditingStyle.Delete;
            }
        }
        
        return UITableViewCellEditingStyle.None
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            tableData.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        } else if (editingStyle == UITableViewCellEditingStyle.Insert) {
            
            let thingToInsert = "\(NSDate())"
            tableData.append(thingToInsert)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
        }
        
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if (indexPath.row == tableData.count) {
    return false
        }

        return true
        
    }
    
func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {

        tableData.insert(tableData[sourceIndexPath.row], atIndex: destinationIndexPath.row)
        tableData.removeAtIndex(sourceIndexPath.row + 1)
    
            
}
    
    
    func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
                if proposedDestinationIndexPath.row == tableData.count {
                return sourceIndexPath
                }
                
                return proposedDestinationIndexPath
    }
    
    
}
