//
//  SuperheroCell.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class SuperheroTableViewCell: UITableViewCell {
    
    private static let DefaultBackgroundColor = UIColor(red: 171/255.0, green: 54/255.0, blue: 36/255.0, alpha: 1)
    private static let SelectedBackgroundColor = UIColor(red: 95/255.0, green: 29/255.0, blue: 76/255.0, alpha: 1)

    var disposeBag: DisposeBag?
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModified: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!
    
    func updateView(_ superhero: SuperheroViewModel) {
        lblName.text = superhero.name
        lblModified.text = superhero.lastModifiedAsTimeAgo
        imgThumbnail.sd_setImage(with: URL(string: superhero.thumbnailUrl),
                                 placeholderImage: UIImage.init(named: "superheroPlaceholder"))
        setupObservers(superhero)
    }
    
    private func setupObservers(_ superhero: SuperheroViewModel) {
        disposeBag = DisposeBag()
        superhero.isFavorite.asObservable()
            .subscribe(onNext: {
                isFavorite in self.imgFavorite.isHidden = !isFavorite
            })
            .disposed(by: disposeBag!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? SuperheroTableViewCell.SelectedBackgroundColor : SuperheroTableViewCell.DefaultBackgroundColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setSelected(highlighted, animated: animated)
    }
}
