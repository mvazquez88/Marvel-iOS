//
//  Superhero.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class Superhero{
    
    private(set) var Name: String
    
    init() {
        Name = String(NSUUID().uuidString.prefix(10))
    }
}
