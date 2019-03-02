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
    
    var canLoadMore: Bool { return superheroService.remoteSuperheroesCount > superheroService.localSuperheroesCount }
    private var isFetchInProgress = false
    
    init(_ superheroService: SuperheroService) {
        self.superheroService = superheroService
    }
    
    func selectHero(_ superhero: SuperheroViewModel){
        selectedHero.value = superhero
    }
    
    func fetchSuperheroes() {
        guard !isFetchInProgress else { return }

        isFetchInProgress = true
        superheroService.fetchSuperheroes(superheroes.value.count, pageSize) { (superheroes) in
            self.superheroes.value += superheroes.map{ SuperheroViewModel($0) }
            self.isFetchInProgress = false
        }
    }

}
