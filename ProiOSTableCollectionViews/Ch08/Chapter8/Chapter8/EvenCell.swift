//
//  EvenCell.swift
//  Chapter8
//
//  Created by Tim on 29/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class EvenCell: UITableViewCell {
    
    @IBOutlet var backView: UIImageView!
    @IBOutlet var iconView: UIImageView!
    @IBOutlet var cellTitle: UILabel!
    @IBOutlet var cellMainContent: UILabel!
    @IBOutlet var cellOtherContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
