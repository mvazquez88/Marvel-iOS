//
//  DetailViewController.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 28/02/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import UIKit
import Dip
import RxSwift

class SuperheroDetailView: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBiography: UILabel!
    @IBOutlet weak var lblLastModified: UILabel!
    
    var disposeBag: DisposeBag? = nil
    var viewModel: SuperheroListViewModel? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        setupObservers()
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = nil
        super.viewWillDisappear(animated)
    }
    
    private func setupObservers() {
        disposeBag = DisposeBag()
        viewModel?.selectedHero.asObservable()
            .subscribe(onNext: {
                _ in self.updateView()
            })
            .disposed(by: disposeBag!)
    }
    
    private func updateView(){
        guard let superhero = viewModel?.selectedHero.value else {
            return
        }

        navigationItem.title = superhero.name
        lblName.text = superhero.name
        lblLastModified.text = superhero.biography
        lblBiography.text = superhero.lastModified
    }
}

