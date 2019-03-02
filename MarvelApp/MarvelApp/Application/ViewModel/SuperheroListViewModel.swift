//
//  SuperheroListViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RxSwift

class SuperheroListViewModel {
    
    let pageSize = 20
    let superheroService: SuperheroService
    let superheroes = Variable<[SuperheroViewModel]>([])
    let selectedHero = Variable<SuperheroViewModel?>(nil)
    
    private var isFetchInProgress = false
    private(set) var totalSuperheroes = 0
    
    init(_ superheroService: SuperheroService) {
        self.superheroService = superheroService
    }
    
    func initialize() {
        fetchSuperheroes()
        totalSuperheroes = superheroService.totalHeroes()
    }
    
    func selectHero(_ superhero: SuperheroViewModel){
        selectedHero.value = superhero
    }
    
    func fetchSuperheroes() {
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true

        superheroes.value += superheroService
            .fetchSuperheroes(superheroes.value.count, pageSize)
            .map{ SuperheroViewModel($0) }

        isFetchInProgress = false
    }

}
