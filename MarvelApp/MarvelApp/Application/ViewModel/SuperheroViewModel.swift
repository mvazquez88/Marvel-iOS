//
//  SuperheroViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RxSwift

class SuperheroViewModel {
    
    let id: Int
    let name: String
    let biography: String
    
    let comicsCount: Int
    let seriesCount: Int
    let storiesCount: Int
    let eventsCount: Int
    
    let lastModifiedAsTimeAgo: String
    let thumbnailUrl: String
    let moreInformationUrl: String

    var isFavorite = Variable<Bool>(false)
    
    init(_ superhero: Superhero, _ isFavorite: Bool) {
        id = superhero.id
        name = superhero.name
        biography = superhero.biography
        
        comicsCount = superhero.comicsCount
        seriesCount = superhero.seriesCount
        storiesCount = superhero.storiesCount
        eventsCount = superhero.eventsCount
        
        lastModifiedAsTimeAgo = superhero.lastModified == Date.distantPast
            ? "Never updated"
            : "Updated \(superhero.lastModified.timeAgoDisplay())"
        
        thumbnailUrl = superhero.thumbnail.contains("image_not_available")
            ? ""
            : superhero.thumbnail.replacingOccurrences(of: "http:", with: "https:")
        
        moreInformationUrl = superhero.deatailUrl.isEmpty
            ? "https://www.marvel.com/explore"
            : superhero.deatailUrl.replacingOccurrences(of: "http:", with: "https:")
        
        self.isFavorite.value = isFavorite
    }
}
