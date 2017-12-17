//
//  ListsDetailTableViewCell.swift
//  MediaPlayer
//
//  Created by T0reto on 13/9/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class ListsDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imageAlbum: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
