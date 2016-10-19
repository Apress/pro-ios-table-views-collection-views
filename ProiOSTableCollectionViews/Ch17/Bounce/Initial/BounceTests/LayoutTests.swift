//
//  LayoutTests.swift
//  Bounce
//
//  Created by Tim Duckett on 03/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import XCTest

@testable import Bounce

class LayoutTests: XCTestCase {
    
    var layout: BounceLayout!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        layout = BounceLayout()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_WhenCalculatingRadiusForSquareCases_CalculatesCorrectly() {
        
        // Assume:
        // CV w:500, h:500
        // item w:50, h:50
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 500, 500), collectionViewLayout: layout)
        
        layout.itemSize = CGSizeMake(50, 50)
        layout.numberOfItems = 1
        
        cv.collectionViewLayout.prepareLayout()

        XCTAssertEqual(layout.radius, 475)
        
    }
    
    func test_WhenCalculatingRadiusForHighCases_CalculatesCorrectly() {
        
        // Assume:
        // CV w:500, h:500
        // item w:50, h:50
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 200, 500), collectionViewLayout: layout)
        
        layout.itemSize = CGSizeMake(50, 50)
        layout.numberOfItems = 1
        
        cv.collectionViewLayout.prepareLayout()
        
        XCTAssertEqual(layout.radius, 175)
        
    }

    func test_WhenCalculatingRadiusForWideCases_CalculatesCorrectly() {
        
        // Assume:
        // CV w:500, h:500
        // item w:50, h:50
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 500, 100), collectionViewLayout: layout)
        
        layout.itemSize = CGSizeMake(50, 50)
        layout.numberOfItems = 1
        
        cv.collectionViewLayout.prepareLayout()
        
        XCTAssertEqual(layout.radius, 75)
        
    }
    
    func test_WhenCalculatingRadiusOffset_CalculatesCorrectly() {
        
        // Assume:
        // CV w:500, h:500
        // item w:50, h:50
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 200, 500), collectionViewLayout: layout)
        
        layout.itemSize = CGSizeMake(50, 50)

        layout.numberOfItems = 2
        cv.collectionViewLayout.prepareLayout()
        XCTAssertEqual(layout.radiusOffset, M_PI)

        layout.numberOfItems = 4
        cv.collectionViewLayout.prepareLayout()
        XCTAssertEqual(layout.radiusOffset, M_PI_2)

        layout.numberOfItems = 3
        cv.collectionViewLayout.prepareLayout()
        XCTAssertEqual(layout.radiusOffset, (2 * M_PI) / 3)

    }
    
    func test_WhenCalculatingFinalCenterPoint_CalculatesCorrectly() {
        
        let cv = UICollectionView(frame: CGRectMake(0, 0, 400, 400), collectionViewLayout: layout)
        
        layout.itemSize = CGSizeMake(50, 50)
        
        layout.numberOfItems = 4

        let indexPath1 = NSIndexPath(forItem: 0, inSection: 0)
        let indexPath2 = NSIndexPath(forItem: 1, inSection: 0)
        let indexPath3 = NSIndexPath(forItem: 2, inSection: 0)
        let indexPath4 = NSIndexPath(forItem: 3, inSection: 0)
        
        let attr1 = layout.layoutAttributesForItemAtIndexPath(indexPath1)
        let attr2 = layout.layoutAttributesForItemAtIndexPath(indexPath2)
        let attr3 = layout.layoutAttributesForItemAtIndexPath(indexPath3)
        let attr4 = layout.layoutAttributesForItemAtIndexPath(indexPath4)
        
        XCTAssertEqual(attr1?.center, CGPointMake(200, 200))
        XCTAssertEqual(attr2?.center, CGPointMake(400, 200))
        XCTAssertEqual(attr3?.center, CGPointMake(200, 400))
        XCTAssertEqual(attr4?.center, CGPointMake(0, 200))
        
    }

    
}
