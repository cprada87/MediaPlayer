//
//  UsersViewController.swift
//  MediaPlayer
//
//  Created by Antonio on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//


import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var button1: UISegmentedControl!
    @IBOutlet weak var tableUsers: UITableView!
    
    var listFriend:[[String:Any]] = []
    var showFriendsInTable = false
    var userData:[String:Any] = [:]
    
    @IBAction func showFriends(_ sender: UISegmentedControl) {
        
        listFriend.removeAll()
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        for user in userDict {
            let userId = user["id"] as! Int
            if sender.selectedSegmentIndex == 1 {
                let userDataFriends = userData["friends"] as! [Int]
                if userDataFriends.contains(userId) {
                    listFriend.append(user)
                }
            } else {
                if user["id"] as! Int != userData["id"] as! Int {
                    listFriend.append(user)
                }
            }
        }
        tableUsers.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        userDict = userDefaults.object(forKey: "users") as! [[String:Any]]
        for user in userDict {
            if user["id"] as! Int != userData["id"] as! Int {
                listFriend.append(user)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFriend.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myUserCell") as! userDetailTableViewCell
        
        if userData["id"] as! Int != listFriend[indexPath.row]["id"] as! Int {
            var userTmp = listFriend[indexPath.row] as [String:Any]
            cell.nameUserCell.text = userTmp["username"] as? String
            cell.mailUserCell.text = userTmp["mail"] as? String
            
            if userTmp["imgFile"] != nil {
                cell.userImageCell.image = UIImage(contentsOfFile: userTmp["imgFile"]! as! String)
            } else {
                cell.userImageCell.image = UIImage(named: userTmp["image"]! as! String)
            }
            
            
            if (userData["friends"] as! [Int]).contains(listFriend[indexPath.row]["id"] as! Int) {
                cell.likeUserCell.image = UIImage(named: "friendyes")
            } else{
                cell.likeUserCell.image = UIImage(named: "friendno")
                
            }
            cell.userImageCell.layer.cornerRadius = 25
            cell.userImageCell.layer.masksToBounds = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        gotoDetail(index: listFriend[indexPath.row]["id"] as! Int)
    }
    
    
    func gotoDetail(index:Int) {
        print("hola")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "userDetailViewController") as! userDetailViewController
        vc.indexReceived = index
        self.navigationController?.pushViewController(vc, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
