//
//  StoryListDto.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct MediaListDto {

    public let available: Int
    public let returned: Int
    public let items: [MediaDto]

    init(_ json: JSON) {
        available = json["available"].intValue
        returned = json["returned"].intValue
        items = json["items"].arrayValue.map { MediaDto($0)}
    }
}
