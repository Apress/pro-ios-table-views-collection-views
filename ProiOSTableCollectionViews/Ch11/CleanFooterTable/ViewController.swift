//
//  ViewController.swift
//  CleanFooterTable
//
//  Created by Tim on 27/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let headerRect = CGRectMake(0, 0, tableView.frame.size.width, 50.0)
        let headerView = UIView(frame: headerRect)
        headerView.backgroundColor = UIColor.cyanColor()
        tableView.tableHeaderView = headerView

        let footerRect = CGRectMake(0, 0, tableView.frame.size.width, 75.0)
        let footerView = UIView(frame: footerRect)
        footerView.backgroundColor = UIColor.cyanColor()
        tableView.tableFooterView = footerView
        
        tableView.tableFooterView = UIView(frame: CGRectZero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        // Configure the cell...
        cell.textLabel!.text = "Row \(indexPath.row)"
        return cell
        
    }

    
}
