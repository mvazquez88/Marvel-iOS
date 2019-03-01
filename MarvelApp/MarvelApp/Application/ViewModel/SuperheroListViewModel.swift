//
//  SuperheroListViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroListViewModel {
    
    let superheroService: SuperheroService
    
    private(set) var superheroes: [SuperheroViewModel]!
    private(set) var selectedHero: SuperheroViewModel? = nil
    
    init(_ superheroService: SuperheroService) {
        self.superheroService = superheroService
        
        superheroes = superheroService.fetchSuperheroes().map{ SuperheroViewModel($0) }
    }
    
    func selectHero(_ superhero: SuperheroViewModel){
        selectedHero = superhero
    }
}
