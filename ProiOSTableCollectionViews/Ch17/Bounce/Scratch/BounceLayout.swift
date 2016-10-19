//
//  BounceLayout.swift
//  Bounce
//
//  Created by Tim Duckett on 05/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class BounceLayout: UICollectionViewLayout {

    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    var cvCenterPoint: CGPoint!
    var indexPathsBeingUpdated = [UICollectionViewUpdateItem]()
    var itemSize: CGSize!
    var sidePadding: CGFloat!
    
    
// MARK: -
// MARK: UICollectionView functions

    override func prepareLayout() {
        
        super.prepareLayout()

        layoutAttributes.removeAll()
        
        // Figure out where the centre of the collection view is
        cvCenterPoint = CGPointMake(collectionView!.frame.size.width / 2, collectionView!.frame.size.height / 2);

        // Figure out the number of items that we're dealing with
        // Here, we assume that there is only one section in the collection view
        let numberOfItems = collectionView!.numberOfItemsInSection(0)
        
        calculateAllAttributes(numberOfItems)

    }

     override func collectionViewContentSize() -> CGSize {
        
        super.collectionViewContentSize()
        
        // The assumption here is that the content size is the same as the collection view size,
        // as it's full screen and won't scroll
        return collectionView!.frame.size
        
    }
        
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        indexPathsBeingUpdated = updateItems
    }
        
        // MARK: -
        // MARK: Attrributes functions
        
    func calculateAllAttributes(numberOfItems: Int) {
        
        // Create the attributes for each item in turn
        for index in 0..<numberOfItems {
            
            // Construct the index path for the item we're dealing with
            let itemIndexPath = NSIndexPath(forItem: index, inSection: 0)
            
            // Create a UICollectionViewLayoutAttributes item for this indexPath
            let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: itemIndexPath)
            
            // Calculate where the centre of the item should be
            let center = calculateCenterForItemAtIndexPath(itemIndexPath)
            attributes.center = center
            
            // Set the item's size
            attributes.size = itemSize
            
            // Set the Z-index so they "stack" on top of each other
            attributes.zIndex = index + 1
            
            // Add our new set of attributes into the array
            layoutAttributes.append(attributes)
            
        }

    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

        // As all elements will be shown, return all of them
        return layoutAttributes

    }
        
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        // Return the layout attributes for the specific item
        return layoutAttributes[indexPath.row]
    }
        
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {

        // Check to see if this indexPath is in the BeingUpdated list
        // if it isn't, we can just bail out
        let indexFound = indexPathsBeingUpdated.indexOf { (element) -> Bool in
            element.indexPathAfterUpdate == itemIndexPath
        }
        
        if indexFound == nil {
            return layoutAttributes[itemIndexPath.row]
        }

        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: itemIndexPath)
        
        // Test to see if we're dealing with a situation where we're removing
        // the second item - there will now only be 1 item, and the indexPath.row that we're
        // dealing with will be 0.
        //
        // In this situation the first item needs to start where it originated, at the top
        if (collectionView!.numberOfItemsInSection(0) == 1) && (itemIndexPath.row == 0) {
            attributes.center = calculateCenterForFirstItem()
            attributes.size = itemSize
            return attributes
        }
        
        // This is a brand new item, so we need to set its alpha, size, z-index and center
        attributes.center = CGPointMake(collectionView!.bounds.size.width / 2, collectionView!.bounds.size.height / 2)
        attributes.alpha = 0
        attributes.size = CGSizeZero
        attributes.zIndex = 0
        
        return attributes;
        
    }

    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: itemIndexPath)
        
        // Check to see if this indexPath is in the BeingUpdated list
        // if it isn't, we can just bail out
        let indexFound = indexPathsBeingUpdated.indexOf { (element) -> Bool in
            element.indexPathBeforeUpdate == itemIndexPath
        }
        
        if indexFound == nil {
            return super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath)
        }

        // Test to see if we're handling the removal of the first item as it moves to make
        // way for the second one.  In this case, there will be 2 items, and the handling indexPath.row
        // of the item we're dealing with will be 0
        //
        // In this scenario, the item needs to end up back at the top center as the
        // only one
        
        if ( (collectionView?.numberOfItemsInSection(0) == 2) && (itemIndexPath.row == 0)  ) {
            attributes.center = calculateCenterForFirstItem()
            attributes.size = itemSize
            attributes.zIndex = 0
            return attributes;
        }
        
        // This is a disappearing item, so we need to set its alpha, size, z-index and center
        // so that it zooms into towards the centre
        
        attributes.center = calculateCenterForFirstItem()
        attributes.alpha = 0
        attributes.size = itemSize
        attributes.zIndex = 0
        return attributes;
    }


        
        // MARK: -
        // MARK: Custom functions

    func calculateCenterForFirstItem() -> CGPoint   {
        return CGPointMake(collectionView!.frame.size.width / 2, collectionView!.frame.size.height / 2);
    }
        
        
    func calculateSpokeRadius() -> CGFloat {
        
        // Calculates the radius of the 'spoke' connecting the item's center and the
        // center of the collectionView
        
        // Find out which is the shorter side, in case
        // the collectionView's not square
        let shorterSide = min(collectionView!.bounds.size.width, collectionView!.bounds.size.height)
        
        let collectionViewAllowance = shorterSide / 2
        let itemWidthAllowance = itemSize.width / 2
        
        // Adjust for side padding (if any)
        return (collectionViewAllowance - (itemWidthAllowance + sidePadding))
        
    }

    func calculateRotationPerItem() -> CGFloat {
        
        // Shouldn't rotate if there's only one item
        
        if (collectionView!.numberOfItemsInSection(0) == 1) {
            return 0.0;
        }
        
        // Otherwise, the rotation is given by 360 / number of items
        // (or 2Pi / number of items as we're dealing with radians here)
        
        return ( CGFloat(2 * M_PI) / CGFloat(collectionView!.numberOfItemsInSection(0)))
        
    }

    func calculateCenterForItemAtIndexPath(indexPath: NSIndexPath) -> CGPoint {
        
        // If there's only one item, then it should be centered
        if (collectionView!.numberOfItemsInSection(0) == 1) {
            return CGPointMake(collectionView!.bounds.size.width / 2, collectionView!.bounds.size.height/2)
        }
        
        // Get angular displacement for this item
        let angularDisplacement: CGFloat = calculateRotationPerItem()
        
        // Calculate rotation required for this item
        let theta = (angularDisplacement * CGFloat(indexPath.row))
        
        // Trig to calculate the x and y shifts required to
        // get the moved around a circle of diameter spoke radius
        let xDisplacement = CGFloat(sinf(Float(theta))) * calculateSpokeRadius()
        let yDisplacement = CGFloat(cosf(Float(theta))) * calculateSpokeRadius()
        
        // Make the centre point of the hour label block
        let xPosition = (collectionView!.bounds.size.width/2) + xDisplacement;
        let yPosition = (collectionView!.bounds.size.width/2) - yDisplacement;
        
        return CGPointMake(xPosition, yPosition)
        
    }

}