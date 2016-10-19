//
//  ViewController.swift
//  SimpleCV
//
//  Created by Tim on 10/01/16.
//  Copyright © 2016 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var suitsArray = [Dictionary<String, AnyObject>]()
    @IBOutlet var collectionView: UICollectionView!
    
    enum ParsingError: ErrorType {
        case MissingJson
        case JsonParsingError
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Configure data
        
        do {
            
            try setupData()
            
        } catch ParsingError.MissingJson {
            
            print("Error loading JSON")
            
        } catch ParsingError.JsonParsingError {
            
            print("Error parsing JSON")
            
        } catch {
            
            print("Something went wrong")
            
        }
        
        // Configure collection view
        configureCollectionView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data setup
    
    func setupData () throws {
            
        guard let filePath = NSBundle.mainBundle().pathForResource("cards", ofType: "json"), jsonData = NSData(contentsOfFile: filePath) else {
            throw ParsingError.MissingJson
        }
    
        do {
            let parsedObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            suitsArray = parsedObject["suits"] as! Array
        } catch {
            throw ParsingError.JsonParsingError
        }
    }
    
    func configureCollectionView() {
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return suitsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cardsDictionary = self.suitsArray[section]
        let cardsArray = cardsDictionary["cards"] as! NSArray
        return cardsArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CardCell", forIndexPath: indexPath)
        
        let suitDictionary = suitsArray[indexPath.section]
        let cardsArray = suitDictionary["cards"] as! [Dictionary<String, AnyObject>]
        let cardDictionary = cardsArray[indexPath.row]
        
        let cardImageName = cardDictionary["cardImage"] as! String
        
        if let cardImage = UIImage(named: cardImageName) {
            
            if let imageView = cell.contentView.viewWithTag(1000) as? UIImageView {
                imageView.image = cardImage
            }
        
        }
        
        return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 10, 10, 10)
        
    }

}

