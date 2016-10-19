//
//  ViewController.swift
//  NamesApp
//
//  Created by Tim on 25/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var collation = UILocalizedIndexedCollation.currentCollation()
    var tableData: [String]!
    var sections: Array<Array<String>> = []
    //var sections: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        parsePlist()
        
        configureSectionData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Name for the letter \(collation.sectionTitles[section])"
    }

    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return collation.sectionTitles
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        let innerData = sections[indexPath.section]
        
        cell.textLabel!.text = innerData[indexPath.row]

        return cell
        
    }
    
    // MARK: -
    // MARK: Header and footer methods

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerFrame = CGRectMake(0, 0, tableView.frame.size.width, 100.0)
        let headerView = UIView(frame: headerFrame)
        headerView.backgroundColor = UIColor(red: 0.5, green: 0.2, blue: 0.57, alpha: 1.0)
        
        let labelFrame = CGRectMake(15.0, 80.0, view.frame.size.width, 15.0)
        let headerLabel = UILabel(frame: labelFrame)
        headerLabel.text = "Section Header"
        headerLabel.font = UIFont(name: "Courier-Bold", size: 18.0)
        headerLabel.textColor = UIColor.whiteColor()

        headerView.addSubview(headerLabel)
        
        return headerView
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerFrame = CGRectMake(0, 0, tableView.frame.size.width, 50.0)
        let footerView = UIView(frame: footerFrame)
        footerView.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.57, alpha: 1.0)
        
        let labelFrame = CGRectMake(15.0, 10.0, view.frame.size.width, 15.0)
        let footerLabel = UILabel(frame: labelFrame)
        footerLabel.text = "Section Footer"
        footerLabel.font = UIFont(name: "Times-New-Roman", size: 12.0)
        footerLabel.textColor = UIColor.blueColor()
        
        footerView.addSubview(footerLabel)
        
        return footerView
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50.0
    }

}

extension ViewController {
    
    func parsePlist() {
        let bundle = NSBundle.mainBundle()
        
        if let plistPath = bundle.pathForResource("Names", ofType: "plist"),
            let namesDictionary = NSDictionary(contentsOfFile: plistPath),
            let names = namesDictionary["Names"] {
                tableData = names as! [String]
        }
    }
    
    func configureSectionData() {
        
        let selector: Selector = "lowercaseString"
        
        sections = Array(count: collation.sectionTitles.count, repeatedValue: [])
        
        let sortedObjects = collation.sortedArrayFromArray(tableData, collationStringSelector: selector)
        
        for object in sortedObjects {
            let sectionNumber = collation.sectionForObject(object, collationStringSelector: selector)
            sections[sectionNumber].append(object as! String)
        }
        
    }

}