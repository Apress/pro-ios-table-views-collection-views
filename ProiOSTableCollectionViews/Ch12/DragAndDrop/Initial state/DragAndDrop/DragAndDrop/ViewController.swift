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

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return cell
    }
    
}

