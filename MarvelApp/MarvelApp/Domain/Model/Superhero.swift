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
    @objc dynamic var lastModified = Date()
    @objc dynamic var thumbnail = ""
}
