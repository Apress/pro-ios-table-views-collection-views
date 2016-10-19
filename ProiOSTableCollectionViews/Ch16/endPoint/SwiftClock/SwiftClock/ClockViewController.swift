//
//  ClockViewController.swift
//  SwiftClock
//
//  Created by Tim on 21/04/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeLabel: UILabel!
    
    let HourCellView = "HourCellView"
    let HourHandCell = "HourHandCell"
    let MinsHandCell = "MinsHandCell"
    let SecsHandCell = "SecsHandCell"

    var clockLayout: ClockLayout!
    
    var dataArray: Array<Array<String>>!
    
    var tickTimer: NSTimer!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        setupData()
        
        configureCollectionView()
        
        tickTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updateClock", userInfo: nil, repeats: true)
        
        NSRunLoop.currentRunLoop().addTimer(tickTimer, forMode: NSRunLoopCommonModes)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        tickTimer.invalidate()
        
    }
    
}

extension ClockViewController {
    
    
    func setupData() {
        
        let handsArray = ["hours", "minutes", "seconds"]
        let hoursArray = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]

        dataArray = [handsArray, hoursArray]
        
    }
    
    func configureCollectionView() {
        
        collectionView.registerNib(UINib(nibName: "HourCell", bundle: nil), forCellWithReuseIdentifier: HourCellView)
        collectionView.registerClass(HandCell.self, forCellWithReuseIdentifier: HourHandCell)
        collectionView.registerClass(HandCell.self, forCellWithReuseIdentifier: MinsHandCell)
        collectionView.registerClass(HandCell.self, forCellWithReuseIdentifier: SecsHandCell)

        clockLayout = ClockLayout()
        collectionView.setCollectionViewLayout(clockLayout, animated: false)

        clockLayout.hourLabelCellSize = CGSizeMake(100.0, 100.0)
        clockLayout.hourHandSize = CGSizeMake(10.0, 140.0)
        clockLayout.minuteHandSize = CGSizeMake(10.0, 200.0)
        clockLayout.secondHandSize = CGSizeMake(6.0, 200.0)

    }

    func updateClock() {

        let currentTime = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.stringFromDate(currentTime)
        
        timeLabel.text = timeString
        
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
}

extension ClockViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let innerArray = self.dataArray[section]
        
        return innerArray.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell!
        
        // Handle time labels
        switch (indexPath.section) {
            
        case 0: // Handle hands
            
            switch (indexPath.row) {
                
            case 0: // Handle hour hands
                
                cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourHandCell, forIndexPath: indexPath) as! HandCell
                let hourHandView = UIView(frame: CGRectMake(0, 0, clockLayout.hourHandSize.width, clockLayout.hourHandSize.height))
                hourHandView.backgroundColor = UIColor.blackColor()
                cell.contentView.addSubview(hourHandView)
                cell.layer.anchorPoint = CGPointMake(0.5, 0.9)
                
            case 1: // handle minute hands
                
                cell = collectionView.dequeueReusableCellWithReuseIdentifier(MinsHandCell, forIndexPath: indexPath) as! HandCell
                let minuteHandView = UIView(frame: CGRectMake(0, 0, clockLayout.minuteHandSize.width, clockLayout.minuteHandSize.height))
                minuteHandView.backgroundColor = UIColor.blackColor()
                cell.contentView.addSubview(minuteHandView)
                cell.layer.anchorPoint = CGPointMake(0.5, 0.9)
                
            default: // handle second hands
                
                cell = collectionView.dequeueReusableCellWithReuseIdentifier(SecsHandCell, forIndexPath: indexPath)
                let secondHandView = UIView(frame: CGRectMake(0, 0, clockLayout.secondHandSize.width, clockLayout.secondHandSize.height))
                secondHandView.backgroundColor = UIColor.redColor()
                cell.contentView.addSubview(secondHandView)
                cell.layer.anchorPoint = CGPointMake(0.5, 0.9)
                
            }
            
        default: // Handle hours labels
            
            cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourCellView, forIndexPath: indexPath) as UICollectionViewCell
            
            let hourLabelsArray = dataArray[1]
            let hoursText = hourLabelsArray[indexPath.row]
            
            if let cellLabel: UILabel = cell.viewWithTag(1000) as? UILabel {
                cellLabel.text = hoursText
            }
            
        }
        
        return cell
        
    }
    
}

