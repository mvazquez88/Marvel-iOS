//
//  SuperheroServiceMock.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import InstantMock
@testable import MarvelApp

class SuperheroServiceMock: Mock, SuperheroServiceProtocol {

    var simulateRequestTime = false
    
    var localSuperheroesCount: Int = 0
    
    var remoteSuperheroesCount: Int = -1
    
    func isFavoriteSuperhero(_ superheroId: Int) -> Bool {
        return super.call(superheroId) ?? false
    }
    
    func setFavoriteSuperhero(_ superheroId: Int, _ favorite: Bool) {
        super.call(superheroId, favorite)
    }
    
    func clearLocalData() {
        super.call()
    }
    
    func fetchSuperheroes(_ offset: Int, _ count: Int, _ onCompleted: (([Superhero]) -> Void)?) {
        super.call(offset, count, onCompleted)

        let characterDto = CharacterDto(CharacterDtoTests().characterJson)
        let result = [Superhero(characterDto), Superhero(characterDto), Superhero(characterDto)]
        
        if (simulateRequestTime) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                onCompleted?(result)
            }
        } else {
            onCompleted?(result)
        }
    }
}
