//
//  ViewController.swift
//  Bounce
//
//  Created by Tim Duckett on 03/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var cvData = [String]()
    
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

extension ViewController {

    func setupData() {
        
        for index in 0...0 {
            cvData.append("\(index)")
        }
        
    }
    
    func setupCollectionView() {
        
        let layout = BounceLayout()
        layout.itemSize = CGSizeMake(75,75)
        layout.sidePadding = 10
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.collectionViewLayout = layout
        
    }
    
    @IBAction func didTapAdd(sender: AnyObject) {

        // Get index of last item
        let index = cvData.count
        
        cvData.append("\(index)")

        // Create an NSIndexPath object for the new item
        let newItemIndexPath = NSIndexPath(forItem: index, inSection: 0)

        // Now update the collection view
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.collectionView.insertItemsAtIndexPaths([newItemIndexPath])
            
            }) { (finished) -> Void in
                
            // code
        }
        

    }

    @IBAction func didTapRemoveItem(sender: AnyObject) {
        
        let itemIndex = cvData.count - 1
        
        removeItemAtIndexPath(NSIndexPath(forItem: itemIndex, inSection: 0))
    }

    func removeItemAtIndexPath(indexPath: NSIndexPath) {
        
        // Don't attempt to remove the last item!
        if cvData.count == 0 {
            return
        }
        
        // Remove it from the data array
        cvData.removeAtIndex(indexPath.row)
        
        // Now update the collection view
        collectionView.deleteItemsAtIndexPaths([indexPath])

    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cvCell", forIndexPath: indexPath)

        let cellLabel = cell.viewWithTag(1000) as! UILabel
        cellLabel.text = "Cell \(indexPath.row)"
        cellLabel.textColor = UIColor.whiteColor()
        
        cell.contentView.layer.borderColor = UIColor.cyanColor().CGColor
        cell.contentView.backgroundColor = UIColor.blackColor()
        cell.contentView.layer.borderWidth = 3.0
        
        return cell
        
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
            
        case 0:
            didTapAdd(indexPath)
            
        default:
            removeItemAtIndexPath(indexPath)
        }
        
    }
    
}