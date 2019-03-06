//
//  SuperheroListViewModelTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 06/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import XCTest
import InstantMock
@testable import MarvelApp

class SuperheroListViewModelTests: XCTestCase {
    
    var superheroServiceMock: SuperheroServiceMock!
    
    override func setUp() {
        superheroServiceMock = SuperheroServiceMock()
    }
    
    override func tearDown() {
        superheroServiceMock = nil
    }
    
    func testCanLoadMoreIsTrueWhenLocalCountIsLessThanRemoteCount() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        superheroServiceMock.localSuperheroesCount = 20
        superheroServiceMock.remoteSuperheroesCount = 2000
        
        XCTAssertTrue(superheroListViewModel.canLoadMore)
    }
    
    func testCanLoadMoreIsFalseWhenLocalCountIsEqualToRemoteCount() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        superheroServiceMock.localSuperheroesCount = 2000
        superheroServiceMock.remoteSuperheroesCount = 2000
        
        XCTAssertFalse(superheroListViewModel.canLoadMore)
    }
    
    func testRefreshClearsLocalDataAndFetchAgainWithOffsetZero() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        superheroServiceMock.expect().call(
            superheroServiceMock.clearLocalData()
        )
        
        superheroServiceMock.expect().call(
            superheroServiceMock.fetchSuperheroes(Arg.eq(0), Arg.any(), Arg.closure())
        )
        
        superheroListViewModel.refresh()
        superheroServiceMock.verify()
    }
    
    func testSelectHeroUpdatesSelectedHeroProperty() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        let newSelectedHero = SuperheroViewModel(Superhero(CharacterDto(CharacterDtoTests().characterJson)), false)
        
        XCTAssertNil(superheroListViewModel.selectedHero.value)
        superheroListViewModel.selectHero(newSelectedHero)
        XCTAssertEqual(newSelectedHero.id, superheroListViewModel.selectedHero.value?.id)
    }
    
    func testFetchSuperherosConcatResultsByDefault() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        XCTAssertEqual(0, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes()
        XCTAssertEqual(3, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes()
        XCTAssertEqual(6, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes()
        XCTAssertEqual(9, superheroListViewModel.superheroes.value.count)
    }
    
    func testFetchSuperherosReplaceResultsWhenClearFlagIsTrue() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        XCTAssertEqual(0, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes(true)
        XCTAssertEqual(3, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes(true)
        XCTAssertEqual(3, superheroListViewModel.superheroes.value.count)
        
        superheroListViewModel.fetchSuperheroes(true)
        XCTAssertEqual(3, superheroListViewModel.superheroes.value.count)
    }
    
    func testMultipleCallsToFetchSuperheroesAreIgnoredWhileFetchIsInProgress() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)

        superheroServiceMock.expect().call(
            superheroServiceMock.fetchSuperheroes(Arg.eq(0), Arg.any(), Arg.closure()), count: 1
        )
        
        superheroServiceMock.simulateRequestTime = true
        
        superheroListViewModel.fetchSuperheroes()
        superheroListViewModel.fetchSuperheroes()
        superheroListViewModel.fetchSuperheroes()
        superheroListViewModel.fetchSuperheroes()
        superheroListViewModel.fetchSuperheroes()
        superheroListViewModel.fetchSuperheroes()
     
        superheroServiceMock.verify()
    }
    
    func testSetFavoriteSuperheroPropagateChanges() {
        let superheroListViewModel = SuperheroListViewModel(superheroServiceMock)
        
        let superhero = SuperheroViewModel(Superhero(CharacterDto(CharacterDtoTests().characterJson)), false)
        
        superheroServiceMock.expect().call(
            superheroServiceMock.setFavoriteSuperhero(Arg.eq(superhero.id), Arg.eq(true)), count: 1
        )
        
        superheroServiceMock.expect().call(
            superheroServiceMock.setFavoriteSuperhero(Arg.eq(superhero.id), Arg.eq(false)), count: 1
        )
    
        superheroListViewModel.setFavoriteHero(superhero, true)
        superheroListViewModel.setFavoriteHero(superhero, false)

        superheroServiceMock.verify()
    }
}
