//
//  SuperheroViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroViewModel {
    
    private let superhero: Superhero
    
    var Name: String { return superhero.Name }
    
    init(_ superhero: Superhero) {
        self.superhero = superhero
    }
}
