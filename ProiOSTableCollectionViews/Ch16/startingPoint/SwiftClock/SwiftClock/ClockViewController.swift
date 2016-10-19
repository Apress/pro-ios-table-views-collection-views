//
//  ClockViewController.swift
//  InitialSwiftClock
//
//  Created by Tim on 21/04/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!

    var dataArray = []
    
    let HourCellIdentifier = "HourCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupData()
        
        configureCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ClockViewController {
    
    // MARK:
    // MARK: UICollectionView methods
    
    func configureCollectionView() {
        
        collectionView.registerNib(UINib(nibName: "HourLabelCell", bundle: nil), forCellWithReuseIdentifier: HourCellIdentifier)
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(100.0, 100.0)
        flowLayout.minimumInteritemSpacing = 25.0
        flowLayout.minimumLineSpacing = 25.0
        
        collectionView.collectionViewLayout = flowLayout
        
    }
    
    func setupData() {
        
        let hoursArray = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
        let handsArray = ["hours", "minutes", "seconds"]
        
        dataArray = [hoursArray, handsArray]
        
    }

    
}

extension  ClockViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let innerArray = dataArray[section]
        return innerArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourCellIdentifier, forIndexPath: indexPath) as UICollectionViewCell
        
        let innerArray = dataArray[indexPath.section]
        
        if let cellLabel: UILabel = cell.viewWithTag(1000) as? UILabel {
            cellLabel.text = innerArray[indexPath.row] as! String
        }
        
        return cell
        
    }
    
}
