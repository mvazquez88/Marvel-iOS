//
//  SuperheroServiceTests.swift
//  MarvelAppTests
//
//  Created by Marcelo Vazquez on 05/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import XCTest
import InstantMock
@testable import MarvelApp

class SuperheroServiceTests: XCTestCase {
 
    var superheroStorageMock: SuperheroStorageMock!
    var marvelApiMock: MarvelApiMock!
    
    override func setUp() {
        superheroStorageMock = SuperheroStorageMock()
        marvelApiMock = MarvelApiMock()
        
        superheroStorageMock.updateMarvelData { (apiData) in
            apiData.totalSuperheroes = 1845
            apiData.favoriteSuperheroIds.append(14)
        }
        
        superheroStorageMock.stub().call(
            superheroStorageMock.getSuperheroes(Arg.any(), Arg.any(), Arg.any())
            ).andReturn([Superhero]())
        
        superheroStorageMock.stub().call(
            superheroStorageMock.countSuperheroes()
            ).andReturn(70)
    }
    
    override func tearDown() {
        superheroStorageMock = nil
        superheroStorageMock = nil
    }
    
    func testFetchSuperheroesUsesLocalDataWhenAvailable() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)
        
        marvelApiMock.reject().call(
            marvelApiMock.fetchSuperheroes(Arg.any(), Arg.any(), Arg.closure())
        )
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getSuperheroes(Arg.eq(0), Arg.eq(20), Arg.any())
        )
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getSuperheroes(Arg.eq(20), Arg.eq(20), Arg.any())
        )
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getSuperheroes(Arg.eq(40), Arg.eq(20), Arg.any())
        )
        
        superheroService.fetchSuperheroes(0, 20) { _ in }
        superheroService.fetchSuperheroes(20, 20) { _ in }
        superheroService.fetchSuperheroes(40, 20) { _ in }
        
        marvelApiMock.verify() // Make sure no API request is performed
        superheroStorageMock.verify()
    }
    
    func testFetchSuperheroesUsesApiWhenLocalDataNotAvailable() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)

        marvelApiMock.expect().call( // The offset for request is 70 because that's how many we already have local
            marvelApiMock.fetchSuperheroes(Arg.eq(70), Arg.any(), Arg.closure())
        )
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getSuperheroes(Arg.eq(80), Arg.any(), Arg.any())
        )
        
        superheroService.fetchSuperheroes(80, 20) { _ in }
        superheroStorageMock.verify()
        marvelApiMock.verify()
    }
    
    func testLocalSuperheroesReturnsCountProvidedByLocalStorage() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)

        superheroStorageMock.expect().call(
            superheroStorageMock.countSuperheroes()
        )
        
        XCTAssertEqual(70, superheroService.localSuperheroesCount)
        superheroStorageMock.verify()
    }
    
    func testRemoteSuperheroesIsProvidedFromStoredApiData() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getMarvelData()
        )
        
        XCTAssertEqual(1845, superheroService.remoteSuperheroesCount)
        superheroStorageMock.verify()
    }

    func testFavoriteSuperheroIdIsProvidedFromSuperheroStorage() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)
        
        superheroStorageMock.expect().call(
            superheroStorageMock.getMarvelData()
        )
        
        XCTAssertTrue(superheroService.isFavoriteSuperhero(14))
        superheroStorageMock.verify()
    }
    
    func testFavoriteSuperheroIsStoredOnSuperheroStorage() {
        let superheroService = SuperheroService(superheroStorageMock, MarvelApiMock())
        let closure : (MarvelApiData) -> Void = Arg.closure()
        
        superheroStorageMock.expect().call(
            superheroStorageMock.updateMarvelData(closure)
        )
        
        superheroService.setFavoriteSuperhero(27, true)
        
        superheroStorageMock.verify()
        XCTAssertTrue(superheroService.isFavoriteSuperhero(27))
    }
    
    func testSetFavoriteSuperheroRemoveFavoriteWhenNoLongerFavorite() {
        let superheroService = SuperheroService(superheroStorageMock, MarvelApiMock())
        let closure : (MarvelApiData) -> Void = Arg.closure()
        
        superheroStorageMock.expect().call(
            superheroStorageMock.updateMarvelData(closure)
        )
        
        superheroService.setFavoriteSuperhero(14, false)
        
        superheroStorageMock.verify()
        XCTAssertFalse(superheroService.isFavoriteSuperhero(14))
    }
    
    func testClearLocalDataDeletesSuperheroes() {
        let superheroService = SuperheroService(superheroStorageMock, marvelApiMock)
        
        superheroStorageMock.expect().call(
            superheroStorageMock.deleteSuperheroes()
        )
        
        superheroService.clearLocalData()
        superheroStorageMock.verify()
    }
}
