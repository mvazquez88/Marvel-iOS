//
//  SuperheroViewModel.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

class SuperheroViewModel {
    
    private let superhero: Superhero
    private let dateFormatter: DateFormatter
    
    var name: String { return superhero.name }
    var biography: String { return superhero.biography }
    var lastModified: String { return dateFormatter.string(from: superhero.lastModified) }
    var thumbnailUrl: String { return superhero.thumbnail.replacingOccurrences(of: "http:", with: "https:") }
    
    var comicsCount: Int { return superhero.comicsCount }
    var seriesCount: Int { return superhero.seriesCount }
    var storiesCount: Int { return superhero.storiesCount }
    var eventsCount: Int { return superhero.eventsCount }
    
    init(_ superhero: Superhero) {
        self.superhero = superhero
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' H:mm:ss"
    }
}
