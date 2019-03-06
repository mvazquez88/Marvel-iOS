//
//  SuperheroViewModelTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import XCTest
@testable import MarvelApp

class SuperheroViewModelTests: XCTestCase {
    
    func testInitMapFieldsProperly() {
        let superhero = Superhero(CharacterDto(CharacterDtoTests().characterJson))
        let superheroViewModel = SuperheroViewModel(superhero, false)
        
        XCTAssertEqual(superhero.id, superheroViewModel.id)
        XCTAssertEqual(superhero.name, superheroViewModel.name)
        XCTAssertEqual(superhero.biography, superheroViewModel.biography)
        
        XCTAssertEqual(superhero.comicsCount, superheroViewModel.comicsCount)
        XCTAssertEqual(superhero.seriesCount, superheroViewModel.seriesCount)
        XCTAssertEqual(superhero.storiesCount, superheroViewModel.storiesCount)
        XCTAssertEqual(superhero.eventsCount, superheroViewModel.eventsCount)
 
        XCTAssertEqual("Updated \(superhero.lastModified.timeAgoString())", superheroViewModel.lastModifiedAsTimeAgo)
        XCTAssertEqual(superhero.thumbnail, superheroViewModel.thumbnailUrl)
        XCTAssertEqual(superhero.detailUrl, superheroViewModel.moreInformationUrl)
        
        XCTAssertFalse(superheroViewModel.isFavorite.value)
    }
    
    func testLastModifiedIsNeverUpdatedWhenDateIsDistantPast() {
        let superhero = Superhero(CharacterDto(CharacterDtoTests().characterJson))
        superhero.lastModified = Date.distantPast
        
        let superheroViewModel = SuperheroViewModel(superhero, false)
        
        XCTAssertEqual("Never updated", superheroViewModel.lastModifiedAsTimeAgo)
    }
    
    func testThumbnailUrlIsEmptyWhenValueIsMarvelApiPlaceholder() {
        let superhero = Superhero(CharacterDto(CharacterDtoTests().characterJson))
        superhero.thumbnail = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available"
        
        let superheroViewModel = SuperheroViewModel(superhero, false)
        
        XCTAssertEqual("", superheroViewModel.thumbnailUrl)
    }
    
    func testMoreInformationFallbacksToMarvelExploreWhenNoUrlIsProvided() {
        let superhero = Superhero(CharacterDto(CharacterDtoTests().characterJson))
        superhero.detailUrl = ""
        
        let superheroViewModel = SuperheroViewModel(superhero, false)
        
        XCTAssertEqual("https://www.marvel.com/explore", superheroViewModel.moreInformationUrl)
    }
    
    func testIsFavoriteUpdatesAccordingToInitParameter() {
        let superhero = Superhero(CharacterDto(CharacterDtoTests().characterJson))
        let superheroViewModel = SuperheroViewModel(superhero, true)
        
        XCTAssertTrue(superheroViewModel.isFavorite.value)
    }
}
