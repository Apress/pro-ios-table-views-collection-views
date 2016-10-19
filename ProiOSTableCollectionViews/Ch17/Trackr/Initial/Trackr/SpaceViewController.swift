//
//  ViewController.swift
//  Trackr
//
//  Created by Tim Duckett on 05/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var cvData = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupData()
        setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SpaceViewController {
    
    func setupData() {
        for index in 0...20 {
            cvData.append(index)
        }
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSizeMake(75, 75)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: "didGetPinchGesture:")
        collectionView.addGestureRecognizer(pinchRecognizer)

    }
    
    func didGetPinchGesture(sender: UIPinchGestureRecognizer) {
        
        guard sender.numberOfTouches() == 2 else {
            return
        }
        
        let pointOne = sender.locationOfTouch(0, inView: collectionView)
        let pointTwo = sender.locationOfTouch(1, inView: collectionView)
        
        let dX = pointOne.x - pointTwo.x
        let dY = pointTwo.y - pointTwo.y
        
        let distance = sqrt(dX * dX + dY * dY)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = distance / 5
        layout.minimumInteritemSpacing = distance / 5
        
        layout.invalidateLayout()
        
    }
    
}

extension SpaceViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellIdentifier", forIndexPath: indexPath)

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = "Cell \(cvData[indexPath.row])"
        
        cell.layer.borderColor = UIColor.redColor().CGColor
        cell.layer.borderWidth = 2.0

        return cell
    }
    
}

