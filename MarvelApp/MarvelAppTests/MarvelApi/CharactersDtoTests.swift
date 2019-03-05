//
//  CharactersDtoTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 05/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import MarvelApp

class CharactersDtoTests: XCTestCase {
    
    let charactersJson : JSON = [
        "offset": 0,
        "limit": 20,
        "total": 1491,
        "count": 20,
        "results": [CharacterDtoTests().characterJson]
    ]
    
    func testInitParsesListOfCharactersProperly() {
        let charactersList = CharactersDto(charactersJson)
        XCTAssertEqual(0, charactersList.offset)
        XCTAssertEqual(20, charactersList.limit)
        XCTAssertEqual(1491, charactersList.total)
        XCTAssertEqual(20, charactersList.count)
        XCTAssertEqual(1011334, charactersList.characters[0].id)
    }
}
