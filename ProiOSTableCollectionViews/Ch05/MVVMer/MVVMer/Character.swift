//
//  Person.swift
//  MVVMer
//
//  Created by Tim on 15/07/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

import UIKit

struct Character {
    
    var firstName: String
    var lastName: String
    var dateOfBirth: NSDate?
    
    init(firstName: String = "", lastName: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = nil
    }
    
}

