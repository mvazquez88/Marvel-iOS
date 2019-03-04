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
    
    private let superhero: Superhero
    
    var id: Int { return superhero.id }
    var name: String { return superhero.name }
    var biography: String { return superhero.biography }
    
    var lastModifiedAsTimeAgo: String {
        return superhero.lastModified != Date.distantPast
        ? "Updated \(superhero.lastModified.timeAgoDisplay())"
        : "Never updated"
    }
    
    var thumbnailUrl = ""
    let moreInformationUrl: String

    var comicsCount: Int { return superhero.comicsCount }
    var seriesCount: Int { return superhero.seriesCount }
    var storiesCount: Int { return superhero.storiesCount }
    var eventsCount: Int { return superhero.eventsCount }
    
    var isFavorite = Variable<Bool>(false)
    
    init(_ superhero: Superhero, _ isFavorite: Bool) {
        self.superhero = superhero
        self.isFavorite.value = isFavorite
        
        if !superhero.thumbnail.contains("image_not_available") {
            thumbnailUrl = superhero.thumbnail.replacingOccurrences(of: "http:", with: "https:")
        }

        if superhero.deatailUrl.isEmpty {
            moreInformationUrl = "https://www.marvel.com/explore"
        } else {
            moreInformationUrl = superhero.deatailUrl.replacingOccurrences(of: "http:", with: "https:")
        }
    }
}
