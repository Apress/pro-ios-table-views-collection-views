//
//  ViewController.swift
//  BabyNames
//
//  Created by Tim on 22/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tableData: [Name]!
    
    let numberOfNames = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableData = loadRandomNames()
        title = "Baby Names"
        automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TableViewController {
    
    func createRandomNameWithNonsenseData() -> Name {
        
        // Create sample data arrays
        
        let namesArray = ["Abigail", "Ada", "Adelaide", "Abel", "Algernon", "Anatole", "Barbara", "Bertha", "Brunhilda", "Barton", "Ben", "Boris", "Calista", "Cassandra", "Constance", "Caspar", "Clive", "Corey", "Danica", "Dido", "Dora", "Darnell", "Dexter", "Dunstan", "Duncan"]
        
        let genderArray = ["Boy", "Girl", "Unisex"]
        
        let notesArray = ["Prosperous and joyful", "A popular name in Victorian times.", "'Bright fair one'. A term of endearment used by the Irish", "'Son of the furrows; ploughman' One of the twelve apostles", "One who is graceful and charming", "'Spear'. A warrior who wielded her spear to the detriment of her enemies"]
        
        let derivationArray = ["Celtic", "Germanic", "Old English", "Latin", "Greek"]
        
        let iconArray = ["baer1.jpg", "baer2.png", "baer3.png", "baer4.png"]
        
        // Get counts of sample data arrays, to act as seeds
        // for the random numbers
        
        let nameCount = UInt32(namesArray.count)
        let genderCount = UInt32(genderArray.count)
        let notesCount = UInt32(notesArray.count)
        let derivationCount = UInt32(derivationArray.count)
        let iconCount = UInt32(iconArray.count)
        
        // Create a Name struct
        var thisName = Name()
        
        // Set some random facts
        thisName.nameText = namesArray[Int(arc4random_uniform(nameCount))]
        thisName.gender = genderArray[Int(arc4random_uniform(genderCount))]
        thisName.notes = notesArray[Int(arc4random_uniform(notesCount))]
        thisName.derivation = derivationArray[Int(arc4random_uniform(derivationCount))]
        thisName.iconName = iconArray[Int(arc4random_uniform(iconCount))]
        
        return thisName
        
    }
    
    func loadRandomNames() -> [Name] {
            
        var namesArray = [Name]()
            
        for _ in 0...numberOfNames {
            
            let thisName = createRandomNameWithNonsenseData()
            namesArray.append(thisName)
            
        }
            
        return namesArray
            
    }
    
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {

    // DataSource methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath)
        
        let name = tableData[indexPath.row]
    
        cell.textLabel!.text = name.nameText

        return cell
        
    }
    
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let detailView = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController

    detailView.displayName = tableData[indexPath.row]
    
    navigationController?.pushViewController(detailView, animated: true)
    
}
}
