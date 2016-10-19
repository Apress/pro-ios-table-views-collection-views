//
//  ViewController.swift
//  SimpleIndex
//
//  Created by Tim on 25/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableData: [String]!
    var indexTitlesArray: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupTableData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func setupTableData() {
        
        tableData = ["Aaron", "Bailey", "Cadan", "Dafydd", "Eamonn", "Fabian", "Gabrielle", "Hafwen", "Isaac", "Jacinta", "Kathleen", "Lucy", "Maurice", "Nadia", "Octavia", "Padraig", "Quinta", "Rachael", "Sabina", "Tabitha", "Uma", "Valentin", "Wallis", "Xanthe", "Yvonne", "Zebadiah"]
        
        let letters = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
        
        indexTitlesArray = letters.componentsSeparatedByString(" ")
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel!.text = tableData[indexPath.section]
        
        return cell
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return indexTitlesArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return indexTitlesArray[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return indexTitlesArray
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return indexTitlesArray.indexOf(title)!
    }
    
}




