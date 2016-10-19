//
//  ViewController.swift
//  BigAssTable
//
//  Created by Tim on 16/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData = [String]()
    var cellCount = 0
    
    var tableView: UITableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.frame = self.view.frame
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        self.view.addSubview(tableView)
        
        for index in 0...99999 {
            tableData.append("Item \(index)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        cell.textLabel!.text = tableData[indexPath.row]
        
        return cell
        
    }

}

