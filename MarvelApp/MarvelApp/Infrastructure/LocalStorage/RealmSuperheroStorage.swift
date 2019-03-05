//
//  RealmLocalStorage.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSuperheroStorage {

    let realm = try! Realm()
}

extension RealmSuperheroStorage: SuperheroStorageProtocol {

    func countSuperheroes() -> Int {
        return realm.objects(Superhero.self).count
    }

    func getSuperheroes(_ offset: Int, _ limit: Int, _ sortedBy: String) -> [Superhero] {
        let heroes = realm.objects(Superhero.self).sorted(byKeyPath: sortedBy)

        let start = min(offset, heroes.count - 1)
        let end = min(start + limit, heroes.count) - 1

        return start < end ? Array(heroes[start...end]) : [Superhero]()
    }

    func insertSuperheroes(_ superheroes: [Superhero]) {
        try! self.realm.write {
            realm.add(superheroes)
        }
    }

    func deleteSuperheroes() {
        try! realm.write {
            let superheroes = realm.objects(Superhero.self)
            realm.delete(superheroes)
        }
    }

    func getMarvelData() -> MarvelApiData {
        if realm.objects(MarvelApiData.self).count == 0 {
            try! realm.write {
                realm.add(MarvelApiData())
            }
        }
        return realm.objects(MarvelApiData.self).first!
    }

    func updateMarvelData(_ update: (MarvelApiData) -> Void) {
        let marvelData = getMarvelData()
        try! realm.write {
            update(marvelData)
        }
    }
}
