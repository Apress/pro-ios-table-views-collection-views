//
//  ViewController.swift
//  InCellCV
//
//  Created by Tim on 07/11/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    var cvData = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            cvData.append(index)
        }
    }
    
    func addButtonToCell(cell: UICollectionViewCell) {
        
        guard cell.contentView.viewWithTag(1000) != nil else {
            return
        }
        
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.tag = 1000
        button.setTitle("Tap me!", forState: UIControlState.Normal)
        button.sizeToFit()

        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: "didTapButtonInCell:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let vConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.CenterX, relatedBy:
            NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)

        let hConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: cell.contentView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: -10)
        
        cell.contentView.addSubview(button)
        cell.contentView.addConstraints([vConstraint, hConstraint])
        
    }
    
    func didTapButtonInCell(sender: UIButton) {
        
        let cell = sender.superview!.superview as! UICollectionViewCell
        let indexPathAtTap = collectionView.indexPathForCell(cell)
        
        let alert = UIAlertController(title: "Something happened!", message: "A button was tapped in item \(indexPathAtTap!.row)", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
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
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellIdentifier", forIndexPath: indexPath)
        
        if let label = cell.contentView.viewWithTag(1000) as? UILabel {
            label.text = "Item \(cvData[indexPath.row])"
        }

        addButtonToCell(cell)
        
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1.0
        
        return cell
        
    }
}

