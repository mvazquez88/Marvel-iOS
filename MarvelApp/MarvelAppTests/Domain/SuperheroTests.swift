//
//  SuperheroTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 05/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import MarvelApp

class SuperheroTests: XCTestCase {

    let characterDto = CharacterDto(CharacterDtoTests().characterJson)
    
    func testInitWithCharacterDtoMapValuesProperly() {
        let superhero = Superhero(characterDto)
        
        XCTAssertEqual(characterDto.id, superhero.id)
        XCTAssertEqual(characterDto.name, superhero.name)
        XCTAssertEqual(characterDto.description, superhero.biography)
        XCTAssertEqual(characterDto.modified, superhero.lastModified)
        XCTAssertEqual(characterDto.thumbnail, superhero.thumbnail)
        
        XCTAssertEqual(characterDto.comics.available, superhero.comicsCount)
        XCTAssertEqual(characterDto.events.available, superhero.eventsCount)
        XCTAssertEqual(characterDto.series.available, superhero.seriesCount)
        XCTAssertEqual(characterDto.stories.available, superhero.storiesCount)
        
        XCTAssertEqual(characterDto.urls.first{ $0.type == "wiki"}!.url, superhero.detailUrl)
    }
    
    func testDetailUrlFallbacksToDetailUrlIfThereIsNoWikiUrl() {
        let characterWithoutWiki : JSON = [
            "id": 1011334,
            "name": "3-D Man",
            "description": "",
            "modified": "2014-04-29T14:18:17-0400",
            "urls": [
                [
                    "type": "detail",
                    "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=6b1f9456e72529da1024b5535357362b"
                ],
                [
                    "type": "comiclink",
                    "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=6b1f9456e72529da1024b5535357362b"
                ]
            ]
        ]
        
        let characterDto = CharacterDto(characterWithoutWiki)
        let superhero = Superhero(characterDto)
        
        XCTAssertEqual("http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=6b1f9456e72529da1024b5535357362b", superhero.detailUrl)
    }
    
    func testDetailUrlIsEmptyIfThereIsNeitherWikiOrDetailUrl() {
        let characterWithoutWikiNorDetail : JSON = [
            "id": 1011334,
            "name": "3-D Man",
            "description": "",
            "modified": "2014-04-29T14:18:17-0400",
            "urls": [
                [
                    "type": "comiclink",
                    "url": "http://marvel.com/comics/characters/1011334/3-d_man?utm_campaign=apiRef&utm_source=6b1f9456e72529da1024b5535357362b"
                ]
            ]
        ]
        
        let characterDto = CharacterDto(characterWithoutWikiNorDetail)
        let superhero = Superhero(characterDto)
        
        XCTAssertEqual("", superhero.detailUrl)
        
    }
    
    func testModifiedDateIsDistantPastWhenOriginalDateIsDefaultUnixTime() {
        let unmodifiedCharacter : JSON = [
            "id": 1011334,
            "name": "3-D Man",
            "description": "",
            "modified": "1970-01-01T00:00:00Z"
        ]
        
        let characterDto = CharacterDto(unmodifiedCharacter)
        let superhero = Superhero(characterDto)
        
        XCTAssertEqual(Date.distantPast, superhero.lastModified)
    }
}
