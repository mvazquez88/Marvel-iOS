//
//  SuperheroServiceProtocol.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

protocol SuperheroServiceProtocol {
    
    var localSuperheroesCount: Int { get }
    
    var remoteSuperheroesCount: Int { get }
    
    func isFavoriteSuperhero(_ superheroId: Int) -> Bool
    
    func setFavoriteSuperhero(_ superheroId: Int, _ isFavorite: Bool)
    
    func clearLocalData()
    
    func fetchSuperheroes(_ offset: Int, _ count: Int, _ onCompleted: (([Superhero]) -> Void)?)
}
