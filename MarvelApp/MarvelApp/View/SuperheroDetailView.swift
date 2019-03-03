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
import SDWebImage

class SuperheroDetailView: UIViewController, StoryboardInstantiatable {
    @IBOutlet weak var imgThumbnail: UIImageView!
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgThumbnail.layer.cornerRadius = imgThumbnail.frame.width / 2
    }
    
    private func updateView(){
        guard let superhero = viewModel?.selectedHero.value else {
            return
        }

        navigationItem.title = superhero.name
        imgThumbnail.sd_setImage(with: URL(string: superhero.thumbnailUrl))
    }
}

