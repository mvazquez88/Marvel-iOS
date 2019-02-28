//
//  SuperheroListViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroListViewModel{
    
    private(set) var superheroes: [SuperheroViewModel]!
    let superheroService = SuperheroService()
    
    init() {
        superheroes = superheroService.fetchSuperheroes().map{ SuperheroViewModel($0) }
    }
}
