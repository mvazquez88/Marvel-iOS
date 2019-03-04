//
//  MarvelApiClient.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 02/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import Alamofire
import CryptoSwift
import SwiftyJSON

class MarvelApiClient {
    let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    let privateKey = "e4e52e823b20e345816c61a10cec35e969dc4826"
    let publicKey = "6b1f9456e72529da1024b5535357362b"
    
    private func prepareRequest(_ relativeUrl: String, _ uriParameters: String) -> String {
        let timestamp = Date().timeIntervalSince1970 * 1000
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        return "\(baseUrl)\(relativeUrl)?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)\(uriParameters)"
    }
}

extension MarvelApiClient: MarvelApiProtocol {
    
    func fetchSuperheroes(_ offset: Int, _ count: Int, _ onSuccess: ((CharactersDto) -> Void)?) -> Void {
        let requestUrl = prepareRequest("characters", "&offset=\(offset)&limit=\(count)")
        Alamofire.request(requestUrl, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    onSuccess?(CharactersDto(JSON(value)))
                case .failure(let error):
                    print(error)
                }
        }
    }
}
