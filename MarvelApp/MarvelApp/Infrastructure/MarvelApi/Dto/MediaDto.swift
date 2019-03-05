//
//  MediaDto.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct MediaDto {

    public let name: String
    public let type: String

    init(_ json: JSON) {
        name = json["name"].stringValue
        type = json["type"].stringValue
    }
}
