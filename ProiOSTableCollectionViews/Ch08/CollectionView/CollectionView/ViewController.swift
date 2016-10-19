//
//  ViewController.swift
//  CollectionView
//
//  Created by Tim on 31/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cvData = [String]()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.registerClass(CustomCell.self, forCellWithReuseIdentifier: "CustomCVCell")
        
        setupData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController {
    
    func setupData() {
        
        for index in 0...100 {
            cvData.append("Cell \(index)")
        }
        
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
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomCVCell", forIndexPath: indexPath) as! CustomCell
    
    cell.cellTitle = cvData[indexPath.row]
    
    return cell
    
}
    
}

