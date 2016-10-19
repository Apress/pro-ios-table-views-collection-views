//
//  CustomCell.swift
//  CollectionView
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var cellTitle: String?
    
    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let cellTitle = cellTitle {
            titleLabel.text = cellTitle
            subtitleLabel.text = "\(cellTitle)'s subtitle"
        }
        
    }
    
}

extension CustomCell {
    
func setupViews() {
    
    // Setup title label
    titleLabel = drawLabel()
    
    let vTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
    
    let hTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
    
    self.contentView.addSubview(titleLabel)
    
    // Setup subtitle label
    subtitleLabel = drawLabel()

    let hSubtitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)

    let vSubtitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: titleLabel, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5)
    
    self.contentView.addSubview(subtitleLabel)
    

    self.contentView.backgroundColor = UIColor.cyanColor()
    
    
    // Apply constraints
    self.contentView.addConstraints([vTitleConstraint, hTitleConstraint, hSubtitleConstraint, vSubtitleConstraint])
    
}
    
    func drawLabel() -> UILabel {
        let cellTitleLabel = UILabel(frame: CGRectZero)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.sizeToFit()
        
        return cellTitleLabel
    }

}
