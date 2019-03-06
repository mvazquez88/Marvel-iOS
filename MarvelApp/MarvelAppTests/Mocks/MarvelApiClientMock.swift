
//
//  MarvelApiClientMock.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import InstantMock
@testable import MarvelApp

class MarvelApiMock: Mock, MarvelApiProtocol {
    func fetchSuperheroes(_ offset: Int, _ count: Int, _ onSuccess: ((CharactersDto) -> Void)?) {
        super.call(offset, count, onSuccess)
        onSuccess?(CharactersDto(CharactersDtoTests().charactersJson))
    }
}
