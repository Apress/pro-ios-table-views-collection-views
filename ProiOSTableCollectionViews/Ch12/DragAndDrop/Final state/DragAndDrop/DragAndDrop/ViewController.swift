//
//  ViewController.swift
//  DragAndDrop
//
//  Created by Tim on 20/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let reuseIdentifier = "ReuseIdentifier"
    private var dataArray = [String]()
    
    private var selectedCell: UICollectionViewCell?
    
    var panGesture: UIPanGestureRecognizer!
    var longPressGesture: UILongPressGestureRecognizer!
    var selectedIndexPath: NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up data
        for index in 0...100 {
            dataArray.append("\(index)")
        }
        
        panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        collectionView!.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: "handleLongGesture:")
        collectionView!.addGestureRecognizer(longPressGesture)
        longPressGesture.delegate = self

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.Began:
            selectedIndexPath = self.collectionView.indexPathForItemAtPoint(gesture.locationInView(self.collectionView))
        case UIGestureRecognizerState.Changed:
            break
        default:
            selectedIndexPath = nil
        }
        
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        
        switch(gesture.state) {
        case UIGestureRecognizerState.Began:
            collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath!)
        case UIGestureRecognizerState.Changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
        case UIGestureRecognizerState.Ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }

}

extension ViewController : UICollectionViewDataSource {
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell
        let label: UILabel = cell.viewWithTag(1000) as! UILabel
        label.text = "Cell \(dataArray[indexPath.row])"
        
        cell.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.contentView.layer.borderWidth = 2.0
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, canMoveItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        // Highlight the cell
        selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.redColor().CGColor
        
        return true
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
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

extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer == longPressGesture {
            return panGesture == otherGestureRecognizer
        }
        
        if gestureRecognizer == panGesture {
            return longPressGesture == otherGestureRecognizer
        }
        
        return true
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        guard gestureRecognizer == self.panGesture else {
            return true
        }
        
        return selectedIndexPath != nil
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.redColor().CGColor
    }

    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let selectedCell = collectionView.cellForItemAtIndexPath(indexPath)
        selectedCell?.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }

}



