//
//  CustomActionsViewController.swift
//  EditingApp
//
//  Created by Tim on 01/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomActionsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var tableData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension CustomActionsViewController {
    
    func setupData() {
        for index in 0...50 {
            tableData.append("\(index)")
        }
    }
    
}

extension CustomActionsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
    
    let tweet = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Tweet") { action, index in
        print("selected tweet action")
        tableView.setEditing(false, animated: true)
    }
    
    tweet.backgroundColor = UIColor.lightGrayColor()

    let facebook = UITableViewRowAction(style: .Normal, title: "Facebook") { action, index in
        print("selected facebook action")
        tableView.setEditing(false, animated: true)
    }
    
    facebook.backgroundColor = UIColor.blueColor()
    
    let email = UITableViewRowAction(style: .Normal, title: "Email") { action, index in
        print("selected email action")
        tableView.setEditing(false, animated: true)
    }
    
    email.backgroundColor = UIColor.purpleColor()
    
    return [tweet, facebook, email]
    
}
    
}

extension CustomActionsViewController: UITableViewDataSource  {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel!.text = "Row \(tableData[indexPath.row])"
        return cell
    }
    
}

