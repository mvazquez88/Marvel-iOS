//
//  MarvelApiProtocol.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation

protocol MarvelApiProtocol {
    func fetchSuperheroes(_ offset: Int, _ count: Int, _ onSuccess: ((CharactersDto) -> Void)?) -> Void
}
