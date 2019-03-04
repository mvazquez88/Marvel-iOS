//
//  MarvelApiData.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import RealmSwift

class MarvelApiData: Object {
    @objc dynamic var totalSuperheroes = 0
    @objc dynamic var favoriteSuperheroId = 0
}
