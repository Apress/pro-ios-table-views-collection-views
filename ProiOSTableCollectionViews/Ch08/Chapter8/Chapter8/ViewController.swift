//
//  ViewController.swift
//  Chapter8
//
//  Created by Tim on 29/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let OddRowHeight: CGFloat = 70.0
    let EvenRowHeight: CGFloat = 100.0
    let OddCellIdentifier = "OddCellIdentifier"
    let EvenCellIdentifier = "EvenCellIdentifier"
    
    var tableData: [String]!
    
    @IBOutlet var tableView: UITableView!
    
override func viewDidLoad() {
    super.viewDidLoad()
    configureTable()
    configureData()
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func configureTable() {
        tableView.registerNib(UINib(nibName: "OddCell", bundle: nil), forCellReuseIdentifier: OddCellIdentifier)
        tableView.registerNib(UINib(nibName: "EvenCell", bundle: nil), forCellReuseIdentifier: EvenCellIdentifier)
    }
    
    func configureData() {
        
        tableData = ["Lorem ipsum dolor sit amet",
            "Consectetur adipiscing elit",
            "Sed do eiusmod tempor incididunt",
            "Labore et dolore magna aliqua",
            "Ut enim ad minim veniam",
            "Quis nostrud exercitation ullamco",
            "Laboris nisi ut aliquip ex ea commodo",
            "Duis aute irure dolor in reprehenderit",
            "Voluptate velit esse cillum dolore",
            "Fugiat nulla pariatur",
            "Excepteur sint occaecat",
            "Cupidatat non proident",
            "Sunt in culpa qui officia",
            "Deserunt mollit anim id est laborum",
            "Nunc sit amet libero ligula",
            "Etiam imperdiet rhoncus enim",
            "In pharetra velit porttitor in",
            "Aliquam non urna ac lectus mollis dignissim",
            "Nunc semper nisi dolor",
            "Non faucibus mauris commodo ac",
            "Sed maximus nunc sem",
            "Dapibus nibh interdum",
            "Quisque ut orci rhoncus, suscipit nisi ut",
            "Integer luctus consectetur aliquam",
            "Nulla ornare lectus malesuada",
            "Morbi dapibus, urna eu mollis pharetra",
            "Lectus eros commodo libero",
            "Et dictum lacus odio ac leo",
            "Integer varius urna quis commodo cursus"
        ]
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count - 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let remainder = indexPath.row % 2

        switch remainder {

        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(EvenCellIdentifier, forIndexPath: indexPath) as! EvenCell
            cell.iconView.image = UIImage(named: "cat")
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "evenBackground")!)
            cell.cellTitle.text = "Cell \(indexPath.row)"
            cell.cellMainContent.text = tableData[indexPath.row]
            cell.cellOtherContent.text = tableData[indexPath.row + 1]
            return cell
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(OddCellIdentifier, forIndexPath: indexPath) as! OddCell
            cell.iconView.image = UIImage(named: "dog")
            cell.backgroundColor = UIColor(patternImage: UIImage(named: "oddBackground")!)
            cell.cellTitle.text = "Cell \(indexPath.row)"
            cell.cellContent.text = tableData[indexPath.row]
            return cell
        }
        
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if (indexPath.row % 2 == 0) {
            return EvenRowHeight
        }
        
        return OddRowHeight
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.backgroundView?.backgroundColor = UIColor.redColor()
    }
    
}

