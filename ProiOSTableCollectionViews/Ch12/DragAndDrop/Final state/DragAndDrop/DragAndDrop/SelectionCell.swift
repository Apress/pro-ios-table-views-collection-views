//
//  SelectionCell.swift
//  DragAndDrop
//
//  Created by Tim on 01/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class SelectionCell: UICollectionViewCell {

    var delegate: CustomMenuDelegate?

    func performDestroy(sender: AnyObject) {
        if let delegate = delegate {
            delegate.performDestroy(sender, forCell: self)
        }
    }

    func addItem(sender: AnyObject) {
        if let delegate = delegate {
            delegate.addItem(sender, atCell: self)
        }
    }
}
    