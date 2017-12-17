//
//  userDetailViewController.swift
//  MediaPlayer
//
//  Created by Antonio on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//


import UIKit
import MapKit
import Localize_Swift

class userDetailViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userLike: UIImageView!
    @IBOutlet weak var userDescription: UITextView!
    @IBOutlet weak var userAge: UILabel!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var gotoMap: UIButton!
    
    var indexReceived:Int?
    var friendData = [String:Any]()
    var userData:[String:Any] = [:]
    var friend = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        for user in userDict {
            if user["id"] as! Int == indexReceived! {
                friendData = user
            }
        }
        
        if friendData["imgFile"] != nil {
            userImage.image = UIImage(contentsOfFile: friendData["imgFile"] as! String)
        } else {
            userImage.image = UIImage(named: friendData["image"] as! String)
        }
        
        userName.text = friendData["username"] as? String
        userDescription.text = friendData["description"] as! String
        userAge.text  = "\(friendData["age"] as! Int)"
        userMail.text = friendData["mail"] as? String
        if (userData["friends"] as! [Int]).contains(friendData["id"] as! Int) {
            userLike.image = UIImage(named: "likeyes")
        } else {
            userLike.image = UIImage(named: "likeno")
        }
        
    }
    
    @IBAction func changeLike(_ sender: Any) {
        var userFriends = userData["friends"] as! [Int]
        
        
        if !(userData["friends"] as! [Int]).contains(friendData["id"] as! Int) {
            userLike.image = UIImage(named: "likeyes")
            userFriends.append(friendData["id"] as! Int)
        } else {
            userLike.image = UIImage(named: "likeno")
            var index = 0
            while index < userFriends.count {
                if userFriends[index] == friendData["id"] as! Int {
                    userFriends.remove(at: index)
                    userFriends.sort()
                    break
                }
                index += 1
            }
        }
        
        userData["friends"] = userFriends
        userDefaults.set(userData, forKey: "user")
        userDefaults.synchronize()
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        
        writeInUserDict(userData: userData)
        
    }
    
     @IBAction func gotoMap(_ sender: Any) {
         let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapDetailViewController") as! MapDetailViewController
       vc.data = ["longitude": friendData["longitude"], "latitude":friendData["latitude"], "title":"friendLocation".localized(), "subtitle":"friendLocationSubtitle".localized()]
      self.navigationController?.pushViewController(vc, animated: true)
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
