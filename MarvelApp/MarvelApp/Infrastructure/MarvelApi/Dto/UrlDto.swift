//
//  UrlDto.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct UrlDto {

    public let url: String
    public let type: String

    init(_ json: JSON) {
        url = json["url"].stringValue
        type = json["type"].stringValue
    }
}
