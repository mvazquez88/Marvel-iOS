//
//  CompositionRoot.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import Dip

class CompositionRoot {

    let container: DependencyContainer = {
        
        let container = DependencyContainer()
        
        registerInfrastructure(container)
        registerDomain(container)
        registerViewModels(container)
        registerViews(container)
        
        return container
    }()
    
    private static func registerInfrastructure(_ container: DependencyContainer) {
        container.register(.unique) { RealmSuperheroStorage() as SuperheroStorageProtocol }
        container.register(.unique) { MarvelApiClient() as MarvelApiProtocol }
    }
    
    private static func registerDomain(_ container: DependencyContainer) {
        container.register(.unique) { try SuperheroService(container.resolve(), container.resolve()) as SuperheroService }
    }
    
    private static func registerViewModels(_ container: DependencyContainer) {
        container.register(.weakSingleton) { try SuperheroListViewModel(container.resolve()) as SuperheroListViewModel }
    }
    
    private static func registerViews(_ container: DependencyContainer) {
        container.register(tag: "SuperheroListView") { SuperheroListView() }
            .resolvingProperties { c, vc in
                vc.viewModel = try container.resolve() as SuperheroListViewModel
        }
        
        container.register(tag: "SuperheroDetailView") { SuperheroDetailView() }
            .resolvingProperties { c, vc in
                vc.viewModel = try container.resolve() as SuperheroListViewModel
        }
        
        DependencyContainer.uiContainers = [container]
    }
}
