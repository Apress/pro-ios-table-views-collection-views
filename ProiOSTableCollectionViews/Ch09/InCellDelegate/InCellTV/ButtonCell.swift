//
//  ButtonCell.swift
//  InCellDelegate
//
//  Created by Tim on 15/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ButtonCell: UITableViewCell {
    
    var delegate: InCellButtonProtocol?

    func didTapButton(sender: AnyObject) {
        if let delegate = delegate {
            delegate.didTapButtonInCell(self)
        }
    }
    
override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

    let button = UIButton(type: UIButtonType.RoundedRect)
    button.tag = 1000
    button.setTitle("Tap me!", forState: UIControlState.Normal)
    button.sizeToFit()
    button.translatesAutoresizingMaskIntoConstraints = false
    
    button.addTarget(self, action: "didTapButton:", forControlEvents: UIControlEvents.TouchUpInside)
    
    //        button.addTarget(cell, action: "didTapButtonInCell", forControlEvents: UIControlEvents.TouchUpInside)
    
    let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterY, relatedBy:
        NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
    
    let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0)
    
    self.contentView.addSubview(button)
    self.contentView.addConstraints([vConstraint, hConstraint])

}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
