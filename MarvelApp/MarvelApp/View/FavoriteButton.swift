//
//  FavoriteButton.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import UIKit

class FavoriteButton {
    
    let barButton: UIBarButtonItem
    let imageView: UIImageView
    let containerView: UIView
    
    weak var delegate: FavoriteButtonDelegate?
    
    var isFavorite: Bool {
        didSet {
            self.imageView.image = UIImage(named: isFavorite ? "favoriteIconFilled" : "favoriteIconEmpty")
        }
    }
    
    init() {
        containerView = UIView(frame: CGRect(x: 0, y: 5, width: 35, height: 35))
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
        isFavorite = false
        
        barButton = UIBarButtonItem(customView: containerView)
        barButton.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBarButtonItemClicked)))
    }
    
    @objc func onBarButtonItemClicked() {
        isFavorite = !isFavorite
        self.delegate?.favoriteTapped(isFavorite)
    }
}

protocol FavoriteButtonDelegate: AnyObject {
     func favoriteTapped(_ isFavorite: Bool)
}
