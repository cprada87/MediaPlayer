//
//  FavoritesTools.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation

func getMusic(musicId: Int) -> [String:Any]{
    for music in musicDict {
        if music["id"] as! Int == musicId {
            return music
        }
    }
    return [:]
}
