//
//  SuperheroService.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import RxSwift

class SuperheroService {
    
    let realm = try! Realm()
    let apiClient = MarvelApiClient()
    
    var localSuperheroesCount: Int { return self.realm.objects(Superhero.self).count }
    var remoteSuperheroesCount: Int { return self.realm.objects(MarvelApiData.self).first?.totalSuperheroes ?? -1 }
    
    func fetchSuperheroes(_ offset:Int = 0, _ count:Int = 20, _ onCompleted: (([Superhero]) -> Void)?) {
        if offset+count < localSuperheroesCount {
            onCompleted?(fetchLocalSuperheroes(offset, count))
        } else {
            fetchRemoteSuperheroes(localSuperheroesCount, count) { onCompleted?(self.fetchLocalSuperheroes(offset, count)) }
        }
    }
    
    private func fetchRemoteSuperheroes(_ offset:Int = 0, _ count:Int = 20, _ onCompleted: (() -> Void)?) {
        apiClient.fetchSuperheroes(offset, count) { (response) in
            try! self.realm.write {
                
                if self.realm.objects(MarvelApiData.self).count == 0 { self.realm.add(MarvelApiData()) }
                let marvelApiData = self.realm.objects(MarvelApiData.self).first!
                marvelApiData.totalSuperheroes = response.total
                
                self.realm.add(response.characters.map { Superhero($0) })
                onCompleted?()
            }
        }
    }
    
    private func fetchLocalSuperheroes(_ offset:Int = 0, _ count:Int = 20) -> [Superhero] {
        let heroes = realm.objects(Superhero.self).sorted(byKeyPath: "name")
        
        let start = min(offset, heroes.count - 1)
        let end = min(start+count, heroes.count) - 1
        
        return start < end ? Array(heroes[start...end]) : [Superhero]()
    }
}
