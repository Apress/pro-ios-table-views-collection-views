//
//  PersonViewModel.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

struct CharacterViewModel {
    
    var displayName: String
    var age: Int?
    
    init(character: Character) {
        
        displayName = character.firstName + " " + character.lastName
        
        if let dob = character.dateOfBirth {
            
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.Year, fromDate: dob, toDate: NSDate(), options: [])
            age = components.year
            
        } else {
            
            age = nil
            
        }
        
    }
    
}
