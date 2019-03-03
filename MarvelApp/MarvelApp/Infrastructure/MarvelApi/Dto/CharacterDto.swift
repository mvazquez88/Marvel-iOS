//
//  CharactedDto.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct CharacterDto {
    
    public let id: Int
    public let name: String
    public let description: String
    public let modified: Date
    public let urls: [UrlDto]
    public let thumbnail: String
    public let comics: MediaListDto
    public let series: MediaListDto
    public let events: MediaListDto
    public let stories: MediaListDto
    
    init(_ json: JSON) {
        id = json["id"].intValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        modified = CharacterDto.dateFormatter.date(from: json["modified"].stringValue)!
        urls = json["urls"].arrayValue.map{ UrlDto($0) }
        thumbnail = "\(json["thumbnail"]["path"].stringValue).\(json["thumbnail"]["extension"].stringValue)"
        comics = MediaListDto(json["comics"])
        series = MediaListDto(json["series"])
        events = MediaListDto(json["events"])
        stories = MediaListDto(json["stories"])
        
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT:0)
        return dateFormatter
    }()
}
