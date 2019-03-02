//
//  SuperheroService.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RealmSwift

class SuperheroService {
    
    let realm = try! Realm()
    
    func fetchSuperheroes(_ offset:Int = 0, _ count:Int = 20) -> [Superhero] {
        let heroes = realm.objects(Superhero.self).sorted(byKeyPath: "id")
        let end = min(offset+count, heroes.count) - 1
        return Array(heroes[offset...end])
    }
    
    func seedInitialData() {
        if realm.objects(Superhero.self).count > 0 { return }
        
        try! realm.write {

            for i in 1...200 {
                let hero = Superhero()
                hero.id = i
                hero.name = "Hero\(i)"
                hero.biography = "Bio\(i)"
                hero.lastModified = Date()
                realm.add(hero)
            }
        }
    }
}
