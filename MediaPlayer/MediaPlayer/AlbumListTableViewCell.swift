//
//  AlbumListTableViewCell.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class AlbumListTableViewCell: UITableViewCell {
    @IBOutlet weak var albumCoverImage:UIImageView!
    @IBOutlet weak var albumTitleImage:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
