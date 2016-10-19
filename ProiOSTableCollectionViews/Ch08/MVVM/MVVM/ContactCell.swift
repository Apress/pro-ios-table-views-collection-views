//
//  ContactCell.swift
//  MVVM
//
//  Created by Tim on 28/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {
    
    var contact: Contact? {

        didSet {
            nameLabel.text = contact?.name
            numberLabel.text = contact?.number
            notesLabel.text = contact?.notes
        }
    }

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!

}
