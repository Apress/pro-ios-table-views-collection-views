//
//  CustomCell.swift
//  Selections
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    var cellTitle: String = ""
    var cellSubtitle: String = ""
    
    var titleLabel: UILabel!
    var middleLabel: UILabel!
    var subtitleLabel: UILabel!

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
        
        // Set label text from properties
        titleLabel.text = cellTitle
        subtitleLabel.text = cellSubtitle
        
        // Set computed label
        middleLabel.text = "...middle..."
        
    }
    
    func setupViews() {
        
        // Remove existing subviews
        // Setup title label
        titleLabel = drawTitle()
        
        let vTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
        
        let hTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 10)

        // Setup middle label
        middleLabel = drawMiddleTitle()
        
        let vMiddleTitleConstraint = NSLayoutConstraint(item: middleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0)
        
        let hMiddleTitleConstraint = NSLayoutConstraint(item: middleLabel, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        // Setup subtitle label
        subtitleLabel = drawSubtitle()
        
        let vSubtitleTitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0)
        
        let hSubtitleTitleConstraint = NSLayoutConstraint(item: subtitleLabel, attribute: NSLayoutAttribute.Right, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: -10)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(middleLabel)
        self.contentView.addSubview(subtitleLabel)

        self.contentView.addConstraints([vTitleConstraint, hTitleConstraint,
            vMiddleTitleConstraint, hMiddleTitleConstraint,
            vSubtitleTitleConstraint, hSubtitleTitleConstraint])
        
    }
    
    func drawTitle() -> UILabel {

        let cellTitleLabel = UILabel(frame: CGRectZero)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.text = cellTitle
        cellTitleLabel.sizeToFit()
        
        return cellTitleLabel
        
    }

    func drawSubtitle() -> UILabel {
        
        let cellSubTitleLabel = UILabel(frame: CGRectZero)
        cellSubTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellSubTitleLabel.text = cellSubtitle
        cellSubTitleLabel.sizeToFit()
        
        return cellSubTitleLabel

    }

    func drawMiddleTitle() -> UILabel {

        let label = UILabel(frame: CGRectZero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "...middle..."
        label.font = UIFont(name: "Georgia", size: 11.0)
        label.sizeToFit()
        
        return label

    }
    

}
