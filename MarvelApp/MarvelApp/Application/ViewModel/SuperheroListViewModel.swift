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

    let superheroService: SuperheroServiceProtocol

    let superheroes = Variable<[SuperheroViewModel]>([])
    let selectedHero = Variable<SuperheroViewModel?>(nil)

    var canLoadMore: Bool {
        return superheroService.remoteSuperheroesCount > superheroService.localSuperheroesCount
    }
    private var isFetchInProgress = false

    init(_ superheroService: SuperheroServiceProtocol) {
        self.superheroService = superheroService
    }

    func refresh() {
        superheroService.clearLocalData()
        fetchSuperheroes(true)
    }

    func setFavoriteHero(_ superhero: SuperheroViewModel, _ isFavorite: Bool) {
        let currentFavoriteId = superheroService.favoriteSuperheroId

        if currentFavoriteId != superhero.id && !isFavorite {
            return
        }

        if (currentFavoriteId != -1 && currentFavoriteId != superhero.id) {
            superheroes.value.first {
                $0.id == currentFavoriteId
            }?.isFavorite.value = false
        }

        superheroes.value.first {
            $0.id == superhero.id
        }?.isFavorite.value = isFavorite
        superheroService.setFavoriteSuperhero(isFavorite ? superhero.id : -1)
    }

    func selectHero(_ superhero: SuperheroViewModel) {
        selectedHero.value = superhero
    }

    func fetchSuperheroes(_ clear: Bool = false) {
        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true
        superheroService.fetchSuperheroes(clear ? 0 : superheroes.value.count, pageSize) { (superheroes) in
            let favoriteSuperheroId = self.superheroService.favoriteSuperheroId
            let superheroesViewModels = superheroes.map {
                SuperheroViewModel($0, $0.id == favoriteSuperheroId)
            }

            if clear {
                self.superheroes.value = superheroesViewModels
            } else {
                self.superheroes.value += superheroesViewModels
            }

            self.isFetchInProgress = false
        }
    }

}
