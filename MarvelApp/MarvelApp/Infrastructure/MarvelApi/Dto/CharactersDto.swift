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
        let data = json["data"]
        
        offset = data["offset"].intValue
        limit = data["limit"].intValue
        count = data["count"].intValue
        total = data["total"].intValue
        
        characters = data["results"].arrayValue.map { CharacterDto($0) }
    }
}
