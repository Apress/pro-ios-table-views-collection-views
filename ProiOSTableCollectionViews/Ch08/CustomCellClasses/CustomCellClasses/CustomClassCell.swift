//
//  CustomClassCell.swift
//  CustomCellClasses
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomClassCell: UITableViewCell {
    
    var cellTitle: String?
    var cellSubtitle: String?
    
    var leftLabel: UILabel!
    var middleLabel: UILabel!
    var rightLabel: UILabel!
    
    
override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
    
}
    
required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        
        leftLabel.text = cellTitle
        rightLabel.text = cellSubtitle
        
        if let image = UIImage(named: "imageName") {
            self.accessoryView = UIImageView(image: image)
        }
        
    }
    
    override func prepareForReuse() {
        print("prepareForReuse")
    }

}

extension CustomClassCell {
    
    // Layout methods
    func setupViews() {
        
        // Setup title label
        leftLabel = drawLabel()
        
        let vLeftLabelConstraint = NSLayoutConstraint(item: leftLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let hLeftLabelConstraint = NSLayoutConstraint(item: leftLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 10)
        
        // Setup middle label
        middleLabel = drawLabel()
        middleLabel.text = "...middle..."
        middleLabel.font = UIFont(name: "Georgia", size: 11.0)
        middleLabel.sizeToFit()
        
        let vMiddleLabelConstraint = NSLayoutConstraint(item: middleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hMiddleLabelConstraint = NSLayoutConstraint(item: middleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        // Setup subtitle label
        rightLabel = drawLabel()
        
        let vRightLabelConstraint = NSLayoutConstraint(item: rightLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let hRightLabelConstraint = NSLayoutConstraint(item: rightLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -10)
        
        self.contentView.addSubview(leftLabel)
        self.contentView.addSubview(middleLabel)
        self.contentView.addSubview(rightLabel)
        
        self.contentView.addConstraints([vLeftLabelConstraint, hLeftLabelConstraint,
            vMiddleLabelConstraint, hMiddleLabelConstraint,
            vRightLabelConstraint, hRightLabelConstraint])
        
    }
    
    func drawLabel() -> UILabel {
        
        let cellTitleLabel = UILabel(frame: CGRectZero)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.sizeToFit()
        
        return cellTitleLabel
        
    }
    
}
