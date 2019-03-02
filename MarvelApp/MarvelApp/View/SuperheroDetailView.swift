//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit
import Dip

class SuperheroDetailView: UIViewController, StoryboardInstantiatable {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBiography: UILabel!
    @IBOutlet weak var lblLastModified: UILabel!
    
    var viewModel: SuperheroListViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView(){
        guard
            let viewModel = viewModel,
            let lblName = lblName
            else { return }
        
        navigationItem.title = viewModel.selectedHero?.name
        lblName.text = viewModel.selectedHero?.name ?? "No hero selected"
        lblLastModified.text = viewModel.selectedHero?.biography ?? ""
        lblBiography.text = viewModel.selectedHero?.lastModified ?? ""
    }
}

