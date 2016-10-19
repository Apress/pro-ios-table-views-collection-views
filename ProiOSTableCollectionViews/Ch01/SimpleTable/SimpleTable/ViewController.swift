//
//  ViewController.swift
//  SimpleTable
//
//  Created by Tim on 10/01/16.
//  Copyright © 2016 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for count in 0...10 {
            // The cell will contain the string "Item X"
            tableData.append("Item \(count)")
        }
        
        // Print out the contents of the data array into the log
        print("The tableData array contains \(tableData)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK:
    //MARK: UITableViewDatasource functions    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel!	.text = tableData[indexPath.row]
        
        return cell
        
    }
    
    // MARK:
    // MARK: UITableViewDelegate functions
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            let messageString = "You tapped row \(indexPath.row)"
            
            let alertController = UIAlertController(title: "Row tapped", message: messageString, preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default,  handler: nil)
            
            alertController.addAction(okAction)
            
            self.presentViewController(alertController, animated: true) {
                print("\(messageString)")
            }
            
    }

    
}

