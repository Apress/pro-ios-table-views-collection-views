//
//  ClockLayout.swift
//  SwiftClock
//
//  Created by Tim on 23/04/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ClockLayout: UICollectionViewLayout {
    
    private var clockTime: NSDate!
    private let dateFormatter = NSDateFormatter()

    private var timeHours: Int!
    private var timeMinutes: Int!
    private var timeSeconds: Int!
    
    var minuteHandSize: CGSize!
    var secondHandSize: CGSize!
    var hourHandSize: CGSize!
    var hourLabelCellSize: CGSize!

    private var clockFaceRadius: CGFloat!
    private var cvCenter: CGPoint!
    
    private var attributesArray = [UICollectionViewLayoutAttributes]()
    
    // MARK:
    // MARK: UICollectionViewLayout functions
    
    override func prepareLayout() {
        
        cvCenter = CGPointMake(collectionView!.frame.size.width/2, collectionView!.frame.size.height/2)
        
        clockTime = NSDate()
        
        dateFormatter.dateFormat = "HH"
        let hourString = dateFormatter.stringFromDate(clockTime)
        timeHours = Int(hourString)!

        dateFormatter.dateFormat = "mm"
        let minString = dateFormatter.stringFromDate(clockTime)
        timeMinutes = Int(minString)!

        dateFormatter.dateFormat = "ss"
        let secString = dateFormatter.stringFromDate(clockTime)
        timeSeconds = Int(secString)!
        
        clockFaceRadius = min(cvCenter.x, cvCenter.y)
        
        calculateAllAttributes()

    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.frame.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        
        // return the item from attributesArray with the matching indexPath

        return attributesArray.filter({ (theAttribute) -> Bool in
            theAttribute.indexPath == indexPath
        }).first
        
    }

    // MARK:
    // MARK: Unused UICollectionViewLayout function
    
    override func layoutAttributesForDecorationViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {

        // Will not get called by this layout, as there are no decoration views involved
        return nil
        
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {

        // Will not get called by this layout, as there are no supplementary views involved
        return nil
        
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        
        // Default value is false
        return false
        
    }

    // MARK:
    // MARK: Custom clock layout functions
    
func calculateAllAttributes() {
    
    for section in 0..<collectionView!.numberOfSections() {
    
        for item in 0..<collectionView!.numberOfItemsInSection(section) {
        
            // Create index path for this item
            let indexPath = NSIndexPath(forItem: item, inSection: section)
            
            // Calculate the attributes
            let attributes = calculateAttributesForItemAt(indexPath)
            
            // Update or insert the newAttributes into the attributesArray
            if let matchingAttributeIndex = attributesArray.indexOf( { (attributes: UICollectionViewLayoutAttributes ) -> Bool in
                attributes.indexPath.compare(indexPath) == NSComparisonResult.OrderedSame
            }) {
    
                // Attribute already existed, therefore replace it
                attributesArray[matchingAttributeIndex] = attributes
    
            } else {
    
                // New set of attributes required
                attributesArray.append(attributes)
                
            }

        }
        
    }

}
    
    func calculateAttributesForItemAt(itemPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        
        var newAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: itemPath)
        
        if itemPath.section == 0 {
            newAttributes = calculateAttributesForHandCellAt(itemPath)
        }

        if itemPath.section == 1 {
            newAttributes = calculateAttributesForHourLabelWith(itemPath)
        }
        
        return newAttributes
        
    }
    
    func calculateAttributesForHourLabelWith(hourPath: NSIndexPath) -> UICollectionViewLayoutAttributes {
        
        // Create new instance of UICollectionViewLayoutAttributes
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: hourPath)
        
        // Calculate overall size of hour label
        attributes.size = hourLabelCellSize
        
        // Calculate the rotation per hour around the clock face
        let angularDisplacement: Double = (2 * M_PI) / 12
        
        let theta = angularDisplacement * Double(hourPath.row)
        
        let xDisplacement = sin(theta) * Double(clockFaceRadius - (attributes.size.width / 2))

        let yDisplacement = cos(theta) * Double(clockFaceRadius - (attributes.size.height / 2))
        
        let xPosition = cvCenter.x + CGFloat(xDisplacement)

        let yPosition = cvCenter.y - CGFloat(yDisplacement)

        let center: CGPoint = CGPointMake(xPosition, yPosition)

        attributes.center = center
        
        return attributes
        
    }
    
    func calculateAttributesForHandCellAt(handPath: NSIndexPath) -> UICollectionViewLayoutAttributes {

        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: handPath)
        
        let rotationPerHour: Double = (2 * M_PI) / 12
        
        let rotationPerMinute: Double = (2 * M_PI) / 60.0
        
        switch handPath.row {
            
        case 0: // handle hour hands

            attributes.size = hourHandSize
            attributes.center = cvCenter
            
            let intraHourRotationPerMinute: Double = rotationPerHour / 60
            
            let currentIntraHourRotation: Double = intraHourRotationPerMinute * Double(timeMinutes)
            
            let angularDisplacement = (rotationPerHour * Double(timeHours)) + currentIntraHourRotation
            
            attributes.transform = CGAffineTransformMakeRotation(CGFloat(angularDisplacement))
            
        case 1: // handle minute hands

            attributes.size = minuteHandSize
            attributes.center = cvCenter
            
            let intraMinuteRotationPerSecond: Double = rotationPerMinute / 60
            
            let currentIntraMinuteRotation: Double = intraMinuteRotationPerSecond * Double(timeSeconds)
            
            let angularDisplacement = (rotationPerMinute * Double(timeMinutes)) + currentIntraMinuteRotation
            
            attributes.transform = CGAffineTransformMakeRotation(CGFloat(angularDisplacement))
            
        case 2: // handle second hands

            attributes.size = secondHandSize
            attributes.center = cvCenter
            
            let angularDisplacement = rotationPerMinute * Double(timeSeconds)
            
            attributes.transform = CGAffineTransformMakeRotation(CGFloat(angularDisplacement))
            
        default:
            break
            
        }
        
        return attributes

    }

}