//
//  LocalStorage.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

protocol SuperheroStorageProtocol {

    func countSuperheroes() -> Int

    func getSuperheroes(_ offset: Int, _ limit: Int, _ sortedBy: String) -> [Superhero]

    func insertSuperheroes(_ superheroes: [Superhero])

    func deleteSuperheroes()

    func getMarvelData() -> MarvelApiData

    func updateMarvelData(_ update: (MarvelApiData) -> Void)
}
