//
//  SuperheroService.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroService{
    
     func fetchSuperheroes() -> [Superhero] {
        return (0...20).map { _ in Superhero() }
    }
}
