//
//  Superhero.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RealmSwift

class Superhero: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var biography = ""
    @objc dynamic var deatailUrl = ""
    @objc dynamic var lastModified = Date()
    @objc dynamic var thumbnail = ""
    
    @objc dynamic var comicsCount = 0
    @objc dynamic var seriesCount = 0
    @objc dynamic var storiesCount = 0
    @objc dynamic var eventsCount = 0
    
    convenience init(_ character: CharacterDto) {
        self.init()
        
        id = character.id
        name = character.name
        biography = character.description
        lastModified = character.modified
        thumbnail = character.thumbnail
        
        comicsCount = character.comics.available
        seriesCount = character.events.available
        storiesCount = character.stories.available
        eventsCount = character.events.available
        
        deatailUrl = (character.urls.first{ $0.type == "wiki" }
            ?? character.urls.first{ $0.type == "detail" })?.url
            ?? ""
    }
    
}
