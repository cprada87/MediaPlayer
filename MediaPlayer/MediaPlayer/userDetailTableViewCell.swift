//
//  userDetailTableViewCell.swift
//  MediaPlayer
//
//  Created by Antonio on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class userDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var likeUserCell: UIImageView!
    @IBOutlet weak var mailUserCell: UILabel!
    @IBOutlet weak var nameUserCell: UILabel!
    @IBOutlet weak var userImageCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

