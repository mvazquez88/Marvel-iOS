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
    @IBOutlet weak var lblComicsCount: UILabel!
    @IBOutlet weak var lblStoriesCount: UILabel!
    @IBOutlet weak var lblEventsCount: UILabel!
    @IBOutlet weak var lblSeriesCount: UILabel!
    @IBOutlet weak var lblBiography: UILabel!
    
    var disposeBag: DisposeBag? = nil
    var viewModel: SuperheroListViewModel? = nil
    var moreInformationUrl: String = ""
    let favoriteButton = FavoriteButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradiendBackground()
        favoriteButton.delegate = self
        self.navigationItem.rightBarButtonItem = favoriteButton.barButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = nil
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
        imgThumbnail.sd_setImage(with: URL(string: superhero.thumbnailUrl), placeholderImage: UIImage.init(named: "superheroPlaceholder"))
        lblBiography.text = superhero.biography
        lblComicsCount.text = "\(superhero.comicsCount)"
        lblStoriesCount.text = "\(superhero.storiesCount)"
        lblEventsCount.text = "\(superhero.eventsCount)"
        lblSeriesCount.text = "\(superhero.seriesCount)"
        
        moreInformationUrl = superhero.moreInformationUrl
        favoriteButton.isFavorite = superhero.isFavorite.value
    }
    
    private func addGradiendBackground() {
        
        let gradientBackground = CAGradientLayer()
        let colorTop = Colors.MarvelRed.cgColor
        let colorBottom = Colors.MarvelRed.withAlphaComponent(0).cgColor
        
        gradientBackground.colors = [colorTop, colorBottom]
        gradientBackground.locations = [0.0, 1.0]
        gradientBackground.frame = view.bounds
        view.layer.insertSublayer(gradientBackground, at: 0)
    }
    
    @IBAction func onLearnMoreTapped(_ sender: Any) {
        if let url = URL(string: moreInformationUrl), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

extension SuperheroDetailView: FavoriteButtonDelegate {
    
    func favoriteTapped(_ isFavorite: Bool) {
        guard let superhero = viewModel?.selectedHero.value else {
            return
        }
        
        viewModel?.setFavoriteHero(superhero, isFavorite)
    }
}

