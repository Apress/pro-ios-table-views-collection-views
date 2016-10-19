//
//  Contact.swift
//  MVVM
//
//  Created by Tim on 28/10/15.
//  Copyright © 2015 Tim Duckett. All rights reserved.
//

struct Contact {
    
    var name: String?
    var number: String?
    var notes: String?
    
    init(name: String, number: String, notes: String) {
        self.name = name
        self.number = number
        self.notes = notes
    }
    
}