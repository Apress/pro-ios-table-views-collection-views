//
//  InterfaceController.swift
//  WatchTarget Extension
//
//  Created by Tim on 03/12/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet var watchTable: WKInterfaceTable!
    var dataArray = [String]()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        setupData()
        updateTable()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupData() {
        dataArray.append("Bob")
        dataArray.append("Felix")
        dataArray.append("Jim")
        dataArray.append("Fred")
    }
    
    func updateTable() {
        
        // Create array to hold the row types
        var rowTypes = [String]()
        
        // Add header row as the row 0
        rowTypes.append("HeaderRow")
        
        // Add a contact row for each object in the dataArray
        for _ in dataArray {
            rowTypes.append("ContactRow")
        }
        
        // Add a footer row as the last row
        rowTypes.append("FooterRow")
        
        // Configure the table to display the rows as defined in the rowsArray
        watchTable.setRowTypes(rowTypes)
        
        // Retrieve each contact row and set the contents from the dataArray
        // Start at row 1, because row 0 is the header row
        for index in 0..<dataArray.count {
        
            let contactRow = watchTable.rowControllerAtIndex(index+1) as! ContactRowController
        
            let rowContent = dataArray[index]
        
            contactRow.nameLabel!.setText(rowContent)
        
            if let image = UIImage(named: rowContent) {
                contactRow.avatarImage.setImage(image)
            }
        
        }
        
        // Get the last row, and configure it as the footer
        
        let contactCount = dataArray.count
        
        let footerRow = watchTable.rowControllerAtIndex(contactCount + 1) as! FooterRowController
        
        footerRow.footerLabel.setText("\(contactCount) messages")
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
            
        table.setRowTypes(["HeaderCell", "DataCell", "DataCell", "FooterCell"])
            
        for index in 0..<dataArray.count {
            let contactRow = watchTable.rowControllerAtIndex(index+1) as! ContactRowController
            contactRow.nameLabel!.setTextColor(UIColor.whiteColor())
        }
        
        let selectedRow = watchTable.rowControllerAtIndex(rowIndex) as! ContactRowController
        
        selectedRow.nameLabel.setTextColor(UIColor.redColor())
        
        let contextDictionary = ["selectedName" : self.dataArray[rowIndex - 1]]
        
        self.pushControllerWithName("DetailInterface", context: contextDictionary)
        
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
            
        if segueIdentifier == "PushDetailScreenSegue" {
            return ["selectedName" : dataArray[rowIndex - 1]]
        }
        
        return nil
            
    }


}
