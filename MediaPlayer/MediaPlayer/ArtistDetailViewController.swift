//
//  ArtistaDetailViewController.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift

class ArtistDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var livesButton: UIButton!
    @IBOutlet weak var artistBackgroundImage: UIImageView!
    
    var artistId:Int?
    var artist:[String:Any] = [:]
    var albumList:[[String:Any]] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if albumList.isEmpty {
            return 1;
        }
        return albumList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumListTableViewCell", for: indexPath) as! AlbumListTableViewCell
        cell.albumTitleImage.text = albumList[indexPath.row]["title"] as! String
        cell.albumCoverImage.image = UIImage(named: albumList[indexPath.row]["image"] as! String)
        return cell
    }
    
    @IBAction func gotoLiveView() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LiveListViewController") as! LiveListViewController
        vc.artistId = artistId
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("hola")
        print(Localize.currentLanguage())
        albumTitleLabel.text = "albumListTitleLabel".localized()
        livesButton.setTitle("liveTitleButton".localized(), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumList = getAlbums(artistId: artistId!)
        artist = getArtist(artistId: artistId!)
        Localize.setCurrentLanguage("base")
        albumTitleLabel.text = "albumListTitleLabel".localized()
        
        livesButton.setTitle("liveTitleButton".localized(), for: .normal)
        
        descriptionTextView.text = artist["description"] as! String
        self.navigationItem.title = artist["name"] as! String
        descriptionTextView.isEditable = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
