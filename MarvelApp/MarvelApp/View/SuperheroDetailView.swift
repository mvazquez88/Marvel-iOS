//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit

class SuperheroDetailView: UIViewController {
    
    @IBOutlet weak var superheroName: UILabel!
    
    var viewModel: SuperheroDetailViewModel? {
        didSet {
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    private func updateView(){
        guard
            let viewModel = viewModel,
            let superheroName = superheroName
            else { return }
        
        superheroName.text = viewModel.superhero.Name
    }
}

