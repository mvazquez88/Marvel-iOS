//
//  LocalStorageMock.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import InstantMock
@testable import MarvelApp

class SuperheroStorageMock: Mock, SuperheroStorageProtocol {
    
    private var apiData = MarvelApiData()
    
    func getSuperheroes(_ offset: Int, _ limit: Int, _ sortedBy: String) -> [Superhero] {
        return super.call(offset, limit, sortedBy)!
    }
    
    func insertSuperheroes(_ superheroes: [Superhero]) {
        return super.call(superheroes)
    }
    
    func deleteSuperheroes() {
        super.call()
    }
    
    func getMarvelData() -> MarvelApiData {
        return super.call() ?? apiData
    }
    
    func updateMarvelData(_ update: (MarvelApiData) -> Void) {
        update(apiData)
        super.call()
    }
    
    func countSuperheroes() -> Int {
        return super.call() ?? 0
    }
}
