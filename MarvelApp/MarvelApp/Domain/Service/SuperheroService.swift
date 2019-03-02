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
        
        let start = min(offset, heroes.count - 1)
        let end = min(start+count, heroes.count) - 1
        
        return start < end ? Array(heroes[start...end]) : [Superhero]()
    }
    
    func totalHeroes() -> Int {
        return realm.objects(Superhero.self).count
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
