//
//  MVVMCell.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

class MVVMCell: UITableViewCell {
   
    var viewModel : Character? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateUI()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateUI() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        nameLabel.text = viewModel.displayName ?? ""
        
        if let age = viewModel.age {
            ageLabel.text = "\(age)"
        } else {
            ageLabel.text = ""
        }
        
    }

}
