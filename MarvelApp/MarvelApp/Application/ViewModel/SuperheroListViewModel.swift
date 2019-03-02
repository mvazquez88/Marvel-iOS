//
//  SuperheroListViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroListViewModel {
    
    private var isFetchInProgress = false
    
    let superheroService: SuperheroService
    
    private(set) var superheroes = [SuperheroViewModel]()
    private(set) var selectedHero: SuperheroViewModel? = nil
    private(set) var totalSuperheroes = 0
    
    init(_ superheroService: SuperheroService) {
        self.superheroService = superheroService
    }
    
    func selectHero(_ superhero: SuperheroViewModel){
        selectedHero = superhero
    }
    
    func initialize() {
        superheroes = superheroService.fetchSuperheroes().map{ SuperheroViewModel($0) }
        totalSuperheroes = superheroService.totalHeroes()
    }
    
    func fetchSuperheroes() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        let additionalHeroes = superheroService.fetchSuperheroes(superheroes.count, 20)
        isFetchInProgress = false
        superheroes.append(contentsOf: additionalHeroes.map{ SuperheroViewModel($0) })
    }
}
