//
//  BusquedaViewController.swift
//  MediaPlayer
//
//  Created by T0reto on 24/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var imageBackgroundSearch: UIImageView!
    
    var searchArray: Array = [[String:Any]]()
    
    var music: Dictionary = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageBackgroundSearch.image = UIImage(named: "concierto")
        self.navigationItem.title = "search".localized()
        searchTextField.placeholder = "searchTextPlaceHolder".localized()
        
        
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
        
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Meter la busqueda aqui o en una funcion
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellSearch", for: indexPath) as! SearchTableViewCell
        
        let dict = searchArray[indexPath.row]
        cell.songLabel.text = dict["title"] as? String
        
        return cell
        
    }
    
    @IBAction func textFiledSearch(_ sender: Any) {
        searchArray.removeAll()
        if (searchTextField.text?.characters.count)! > 2 {
            
            for item in musicDict {
                
                let search = searchTextField.text
                print(item)
                let songTitle = item["title"] as! String
                print(songTitle)
                if songTitle.contains(search!) {
                    searchArray.append(item)
                }
            }
            searchTableView.reloadData()
        } else if (searchTextField.text?.characters.count)! <= 2 {
            
            searchTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToPlayer(index: indexPath.row)
    }
    
    func goToPlayer(index:Int) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
        vc?.musicList = [[String:Any]]()
        vc?.musicList.append(music)
                self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}
