//
//  SuperheroService.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import RxSwift

class SuperheroService: SuperheroServiceProtocol {

    let localStorage: SuperheroStorageProtocol
    let apiClient: MarvelApiProtocol

    var localSuperheroesCount: Int {
        return localStorage.countSuperheroes()
    }
    var remoteSuperheroesCount: Int {
        return localStorage.getMarvelData().totalSuperheroes
    }

    init(_ localStorage: SuperheroStorageProtocol, _ apiClient: MarvelApiProtocol) {
        self.localStorage = localStorage
        self.apiClient = apiClient
    }
    
    func isFavoriteSuperhero(_ superheroId: Int) -> Bool {
        return localStorage.getMarvelData().favoriteSuperheroIds.contains(superheroId)
    }

    func setFavoriteSuperhero(_ superheroId: Int, _ isFavorite: Bool) {
        localStorage.updateMarvelData { marvelData in
            
            if !isFavorite {
                if let index = marvelData.favoriteSuperheroIds.firstIndex(of: superheroId) {
                    marvelData.favoriteSuperheroIds.remove(at: index)
                }
                return
            } else {
                if  marvelData.favoriteSuperheroIds.firstIndex(of: superheroId) == nil {
                    marvelData.favoriteSuperheroIds.append(superheroId)
                }
            }
        }
    }

    func clearLocalData() {
        localStorage.deleteSuperheroes()
    }

    func fetchSuperheroes(_ offset: Int = 0, _ count: Int = 20, _ onCompleted: (([Superhero]) -> Void)?) {
        if offset + count < localSuperheroesCount {
            onCompleted?(fetchLocalSuperheroes(offset, count))
        } else {
            fetchRemoteSuperheroes(localSuperheroesCount, count) {
                onCompleted?(self.fetchLocalSuperheroes(offset, count))
            }
        }
    }

    private func fetchRemoteSuperheroes(_ offset: Int = 0, _ count: Int = 20, _ onCompleted: (() -> Void)?) {
        apiClient.fetchSuperheroes(offset, count) { (response) in
            self.localStorage.updateMarvelData({ marvelData in
                marvelData.totalSuperheroes = response.total
            })
            self.localStorage.insertSuperheroes(response.characters.map {
                Superhero($0)
            })
            onCompleted?()
        }
    }

    private func fetchLocalSuperheroes(_ offset: Int = 0, _ count: Int = 20) -> [Superhero] {
        return localStorage.getSuperheroes(offset, count, "name")
    }
}
