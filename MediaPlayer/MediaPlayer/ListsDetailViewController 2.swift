//
//  ListasDetailViewController.swift
//  MediaPlayer
//
//  Created by T0reto on 23/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//
//
import UIKit

class ListsDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    var indexData:Int?
    var music: [[String:Any]] = []
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        print("index data\(String(describing: indexData))")
        
        self.navigationItem.title = listDict[indexData!]["title".localized()] as! String
        
        for item in musicDict{
            
            let musicLists = item["lists"] as! [Int]
            if musicLists.contains(indexData!) {
              music.append(item)
                
            }
        }

        print(music)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
        print(music.count)
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumId = music[indexPath.row]["albumId"] as! Int
        var album = albumDict[albumId]
        var artist = artistDict[album["artistId"] as! Int]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellDetailLists", for: indexPath) as! ListsDetailTableViewCell
        cell.imageAlbum.image = UIImage(named: album["image"] as! String)
        cell.artistLabel.text = artist["name"] as? String
        cell.songLabel.text = music[indexPath.row]["title"] as? String
            
            return cell
    }
        
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToUserDetalle(index: indexPath.row)
    }
    
    func goToUserDetalle(index:Int) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
//       vc?.musicList = music
//        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
