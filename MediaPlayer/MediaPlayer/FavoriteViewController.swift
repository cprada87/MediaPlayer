//
//  FavoriteViewController.swift
//  MediaPlayer
//
//  Created by Antonio on 9/10/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let cellIdentifier = "Cell"
    var userData = [String:Any]()
    var userFavs:[Int]?
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        userFavs = userData["favs"] as? [Int]
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userFavs != nil && !(userFavs?.isEmpty)! {
            return userFavs!.count
        } else {
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = getMusic(musicId: (userFavs?[indexPath.row])!)
        let album = albumDict[music["albumId"] as! Int]
        let artist = artistDict[album["artistId"] as! Int]
        

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        
        cell.textLabel?.text = "\(artist["name"]!) - \(music["title"]!)"
    
        cell.MusicLabel.text = music["title"] as? String
        cell.ArtistLabel.text = artist["name"] as? String
        cell.imageFavorite.image = UIImage(named: (album["image"]! as? String)!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if userFavs != nil && userFavs!.count > 0 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            for musicId in userFavs! {
                let musicData = getMusic(musicId: musicId)
                let album = albumDict[musicData["albumId"] as! Int]
                let artist = artistDict[album["artistId"] as! Int]
                var musicTmp = musicData
                musicTmp["artist"] = artist
                musicTmp["album"] = album
                vc.musicList.append(musicTmp)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
