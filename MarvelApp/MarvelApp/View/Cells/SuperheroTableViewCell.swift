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
import SDWebImage

class SuperheroTableViewCell: UITableViewCell {

    private static let defaultBackgroundColor = UIColor(red: 171 / 255.0, green: 54 / 255.0, blue: 36 / 255.0, alpha: 1)
    private static let selectedBackgroundColor = UIColor(red: 95 / 255.0, green: 29 / 255.0, blue: 76 / 255.0, alpha: 1)
    private static let placeholderImage = UIImage.init(named: "superheroPlaceholder")

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModified: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView!

    var disposeBag: DisposeBag?

    override func awakeFromNib() {
        super.awakeFromNib()
        imgThumbnail.sd_setShowActivityIndicatorView(true)
        imgThumbnail.sd_setIndicatorStyle(.whiteLarge)
    }

    override func prepareForReuse() {
        imgThumbnail.sd_cancelCurrentImageLoad()
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected
                ? SuperheroTableViewCell.selectedBackgroundColor
                : SuperheroTableViewCell.defaultBackgroundColor
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        setSelected(highlighted, animated: animated)
    }
}

extension SuperheroTableViewCell {

    func updateView(_ superhero: SuperheroViewModel) {
        lblName.text = superhero.name
        lblModified.text = superhero.lastModifiedAsTimeAgo
        let imageUrl = URL(string: superhero.thumbnailUrl)
        imgThumbnail.sd_showActivityIndicatorView()
        imgThumbnail.sd_setImage(with: imageUrl, placeholderImage: SuperheroTableViewCell.placeholderImage)
        setupObservers(superhero)
    }

    private func setupObservers(_ superhero: SuperheroViewModel) {
        disposeBag = DisposeBag()
        superhero.isFavorite.asObservable()
                .subscribe(onNext: {
                    isFavorite in
                    self.imgFavorite.isHidden = !isFavorite
                })
                .disposed(by: disposeBag!)
    }
}
