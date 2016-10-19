//
//  ViewController.swift
//  InCellTV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var tableData = [Int]()
    

override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    setupData()
    
    refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: "didPullRefresh:", forControlEvents: .ValueChanged)
    tableView.addSubview(refreshControl)
    
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {

    func setupData() {
        for index in 0...5 {
            tableData.append(index)
        }
    }
    
    func didPullRefresh(sender: UIRefreshControl) {
        
        tableData.append(tableData.count)
        tableView.reloadData()
        
        sender.endRefreshing()
        
    }

    func didTapButtonInCell(sender: UIButton) {
        
        let cell = sender.superview!.superview as! UITableViewCell
        let indexPathAtTap = tableView.indexPathForCell(cell)
        
        let alert = UIAlertController(title: "Something happened!", message: "A button was tapped at row \(indexPathAtTap!.row)", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
        
    func addButtonToCell(cell: UITableViewCell) {
        
        guard cell.viewWithTag(1000) == nil else {
            return
        }
        
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.tag = 1000
        button.setTitle("Tap me!", forState: UIControlState.Normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "didTapButtonInCell:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy:
            NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -20)
        
        cell.contentView.addSubview(button)
        cell.contentView.addConstraints([vConstraint, hConstraint])

    }

}

extension ViewController: UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = "Row \(tableData[indexPath.row])"

        addButtonToCell(cell)
        
        return cell
    }
    
}

