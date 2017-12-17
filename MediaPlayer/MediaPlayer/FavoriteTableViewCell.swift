//
//  FavoriteTableViewCell.swift
//  MediaPlayer
//
//  Created by user125887 on 9/13/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFavorite: UIImageView!
    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var MusicLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
