//
//  ViewController.swift
//  TableSearch
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!

    var tableData = [String]()
    var filteredTableData = [String]()
    
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController {

    func setupData() {
        
        if let results = arrayFromContentsOfFileWithName("spatowns") {
            tableData = results
        }
        
    }
    
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            return content.componentsSeparatedByString(",\n")
        } catch _ as NSError {
            return nil
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchActive {
            return filteredTableData.count
        }
        
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        if searchActive {
            cell.textLabel?.text = filteredTableData[indexPath.row]
        } else {
            cell.textLabel!.text = tableData[indexPath.row]
        }
        
        return cell
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchActive = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count == 0 {
            searchActive = false
            tableView.reloadData()
            return
        }
        
        searchActive = true
        
        filteredTableData = tableData.filter({( spaTown: String) -> Bool in
            
            let spaRange = Range(start: spaTown.startIndex, end: spaTown.endIndex)
            
            let stringMatch = spaTown.rangeOfString(searchText,
                options: NSStringCompareOptions.CaseInsensitiveSearch,
                range: spaRange,
                locale: NSLocale.autoupdatingCurrentLocale())
            
            return stringMatch != nil
            
        })
        
        tableView.reloadData()
        
    }
    
}