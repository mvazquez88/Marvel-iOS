//
//  CharactersDto.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct CharactersDto {

    public let offset: Int
    public let limit: Int
    public let count: Int
    public let total: Int
    public let characters: [CharacterDto]

    init(_ json: JSON) {
        offset = json["offset"].intValue
        limit = json["limit"].intValue
        count = json["count"].intValue
        total = json["total"].intValue
        characters = json["results"].arrayValue.map { CharacterDto($0) }
    }
}
