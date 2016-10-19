//
//  DetailInterfaceController.swift
//  WatchTable
//
//  Created by Tim on 07/12/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import WatchKit
import Foundation


class DetailInterfaceController: WKInterfaceController {
    
    @IBOutlet var nameLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let contextDictionary = context as? Dictionary<String, String> {
        
            if let selectedName =  contextDictionary["selectedName"] {
                    nameLabel.setText("You selected the row for \(selectedName)")
            }
        
        }
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
