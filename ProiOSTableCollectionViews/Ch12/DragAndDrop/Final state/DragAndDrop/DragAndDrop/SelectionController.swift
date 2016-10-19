//
//  CollectionViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

protocol CustomMenuDelegate {
    func performDestroy(sender: AnyObject, forCell:SelectionCell)
    func addItem(sender: AnyObject, atCell: SelectionCell)
}


private let reuseIdentifier = "ReuseIdentifier"

class SelectionController: UICollectionViewController {

    private let reuseIdentifier = "ReuseIdentifier"
    private var dataArray = [String]()
    private var selectedCell: UICollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow drag-and-drop interaction
        self.installsStandardGestureForInteractiveMovement = true
        
        // Set up data
        for index in 0...100 {
            dataArray.append("\(index)")
        }
        
        let destroyMenuItem = UIMenuItem(title: "Destroy!", action: "performDestroy:")
        let addMenuItem = UIMenuItem(title: "Add!", action: "addItem:")
        UIMenuController.sharedMenuController().menuItems = [addMenuItem, destroyMenuItem]
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SelectionCell", forIndexPath: indexPath) as! SelectionCell
        
        // Configure the cell
        cell.delegate = self
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }

    // MARK: -
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {

        switch action.description {
            
        case "performDestroy:" :
            return true
            
        case "addItem:" :
            return true
            
        default :
            return false
        
        }
        
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    }
    
}

extension SelectionController : CustomMenuDelegate {
    
    func performDestroy(sender: AnyObject, forCell: SelectionCell) {
        
        // Delete cell
        if let indexPath = collectionView?.indexPathForCell(forCell) {
            dataArray.removeAtIndex(indexPath.row)
            collectionView?.reloadData()
        }
        
    }
    
func addItem(sender: AnyObject, atCell: SelectionCell) {

    if let indexPath = collectionView?.indexPathForCell(atCell) {
        dataArray.insert("NEW", atIndex: indexPath.row)
        collectionView?.reloadData()
    }
    
}
}
