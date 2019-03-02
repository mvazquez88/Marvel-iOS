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

class MarvelApiClient {
    
    private func prepareRequest(_ relativeUrl: String) -> String{
        let baseUrl = "https://gateway.marvel.com:443/v1/public/"
        let timestamp = Date().timeIntervalSince1970 * 1000
        let privateKey = "e4e52e823b20e345816c61a10cec35e969dc4826"
        let publicKey = "6b1f9456e72529da1024b5535357362b"
        
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5()
        
        return "\(baseUrl)\(relativeUrl)?ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    func fetchTotalHeroes() -> Int {
        let requestUrl = prepareRequest("characters")
        Alamofire.request(requestUrl, method: .get)
            .validate()
            .responseJSON { response in
                print("Request: \(String(describing: response.request))")   // original url request
                print("Response: \(String(describing: response.response))") // http url response
                print("Result: \(response.result)")                         // response serialization result
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                
                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                    print("Data: \(utf8Text)") // original server data as UTF8 string
                }
        }
        
        return 100
    }
    
}
