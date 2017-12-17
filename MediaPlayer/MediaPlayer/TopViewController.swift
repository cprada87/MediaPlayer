//
//  TopViewController.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift

class TopViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // PARA EL TOP
    
    var song: [String:Any] = [:]
    var imagen: [String:Any] = [:]
    var artista: [String:Any] = [:]
    var music: [[String:Any]] = []
    
    @IBOutlet weak var buttonSearch: UIBarButtonItem!
    @IBOutlet weak var imageBackground: UIImageView!
    // PARA EL COLLECTION
    
    var imagenCollection: [String:Any] = [:]
    var labelCollection: [String:Any] = [:]
    @IBOutlet weak var genderLabel: UILabel!
    
    // TOP OUTLET
    @IBOutlet weak var myImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myImageView.image = UIImage(named: "Musica")
        //genderLabel.text = "gender".localized()
        self.navigationItem.title = "music".localized()
        buttonSearch.title = "search".localized()
        imageBackground.image = UIImage(named: "concierto")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topMusicDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        song = topMusicDict[indexPath.row] as [String:Any]
        imagen = topMusicDict[indexPath.row] as [String:Any]
        artista = topMusicDict[indexPath.row] as [String:Any]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TopTableViewCell
        cell.musicLabel.text = song["title"] as? String
        cell.albumImage.image = UIImage(named: imagen["image"] as! String)
        cell.artistLabel.text = artista["name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToReproductor(tableSelected: true)
    }
    
    
    func goToReproductor(tableSelected: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        if tableSelected {
            vc.musicList = topMusicDict
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // LISTA DE GENEROS
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        imagenCollection = listDict[indexPath.row] as [String:Any]
        labelCollection = listDict[indexPath.row] as [String:Any]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollecionCell", for: indexPath) as! ListCollectionViewCell
        cell.imageCollection.image = UIImage(named: imagenCollection["image"] as! String)
        cell.nameGenereCollection.text = labelCollection["title"] as? String
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToLists(index: indexPath.row)
    }
    
    func goToLists(index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListsDetailViewController") as! ListsDetailViewController
        vc.indexData = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func buttonSearch(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
