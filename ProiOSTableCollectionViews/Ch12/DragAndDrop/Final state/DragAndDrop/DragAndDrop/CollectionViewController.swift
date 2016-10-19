//
//  CollectionViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ReuseIdentifier"

class CollectionViewController: UICollectionViewController {

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

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }

    // MARK: -
    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Highlight the cell
        selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.redColor().CGColor

        return true
    }
    
    override func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        // Find object to move
        let thingToMove = dataArray[sourceIndexPath.row]
        
        // Remove old object
        dataArray.removeAtIndex(sourceIndexPath.row)
        
        // insert new copy of thing to move
        dataArray.insert(thingToMove, atIndex: destinationIndexPath.row)
        
        // Set the cell's background to the original light grey
        selectedCell?.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        // Reload the data
        collectionView.reloadData()
        
    }

}
