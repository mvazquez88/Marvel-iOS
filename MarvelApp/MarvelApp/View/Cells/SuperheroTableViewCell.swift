//
//  SuperheroCell.swift
//  MarvelApp
//
//  Created by Marcelo Vazquez on 04/03/2019.
//  Copyright © 2019 Marcelo Vazquez. All rights reserved.
//

import Foundation
import UIKit

class SuperheroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblModified: UILabel!
    
    func updateView(_ superhero: SuperheroViewModel) {
        lblName.text = superhero.name
        lblModified.text = superhero.lastModifiedAsTimeAgo
        imgThumbnail.sd_setImage(with: URL(string: superhero.thumbnailUrl))
    }
}
