//
//  ViewController.swift
//  Trackr
//
//  Created by Tim Duckett on 05/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class SizingViewController: UIViewController {
    
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

extension SizingViewController {
    
    func setupData() {
        for index in 0...20 {
            cvData.append(index)
        }
    }
    
    func setupCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.itemSize = CGSizeMake(375, 375)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
    }
    
}

extension SizingViewController: UICollectionViewDataSource {
    
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
        cellLabel.textColor = UIColor.whiteColor()
        cell.contentView.backgroundColor = UIColor.cyanColor()
        cell.contentView.layer.borderColor = UIColor.blueColor().CGColor
        cell.contentView.layer.borderWidth = 2.0
        return cell
    }
    
}

