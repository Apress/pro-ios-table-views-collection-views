//
//  ViewController.swift
//  MVVM
//
//  Created by Tim on 28/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var tableData: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func setupData() {
        
        for index in 1...10 {
            
            let contact = Contact(name: "Name \(index)", number: "\(index)", notes: "The notes for contact \(index)")
            tableData.append(contact)
            
        }
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! ContactCell
        
        let contact = tableData[indexPath.row]
        
        cell.contact = contact
        
        return cell
        
    }

    
}

