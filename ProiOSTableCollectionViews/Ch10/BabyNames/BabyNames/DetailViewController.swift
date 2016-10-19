//
//  DetViewController.swift
//  BabyNames
//
//  Created by Tim on 24/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var displayName: Name?
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var derivationLabel: UILabel!
    @IBOutlet var notesLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let displayName = displayName {
            
            nameLabel.text = displayName.nameText
            genderLabel.text = displayName.gender
            derivationLabel.text = displayName.derivation
            notesLabel.text = displayName.notes
        
            if let iconName = displayName.iconName {
                iconImageView.image = UIImage(named: iconName)

            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
