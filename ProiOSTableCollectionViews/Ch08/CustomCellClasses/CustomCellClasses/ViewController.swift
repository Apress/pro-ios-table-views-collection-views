//
//  ViewController.swift
//  CustomCellClasses
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableData = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupData()
        setupTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func setupTable() {
        
        tableView.registerClass(CustomClassCell.self, forCellReuseIdentifier: "CustomTVCell")
        
    }
    
    func setupData() {
        
        for index in 0...50 {
            tableData.append("\(index)")
        }
        
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

        let cell = tableView.dequeueReusableCellWithIdentifier("CustomTVCell", forIndexPath: indexPath) as! CustomClassCell
        
        cell.cellTitle = "Cell \(tableData[indexPath.row])..."
        cell.cellSubtitle = "...\(tableData[indexPath.row]) lleC"
        
        return cell
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
}

