//
//  settingsGeneralViewController.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift
import TextFieldEffects


class settingsGeneralViewController: UIViewController {
    
    @IBOutlet weak var languageLbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var textViewAbout: UITextView!
    @IBOutlet weak var generalAdjLabel: UILabel!
    @IBOutlet weak var privacyProfileSwitch: UISwitch!
    @IBOutlet weak var privacyFriendsSwitch: UISwitch!
    @IBOutlet weak var privacyLocSwitch: UISwitch!
    
    var userData = [String:Any]()
    
    @IBAction func setSpanish(_ sender: Any) {
        Localize.setCurrentLanguage("es-ES")
        updateLanguage()
    }
    
    @IBAction func setEnglish(_ sender: Any) {
        Localize.setCurrentLanguage("en")
        updateLanguage()
    }
    
    @IBAction func setFrance(_ sender: Any) {
        Localize.setCurrentLanguage("fr")
        updateLanguage()
    }
    
    @IBAction func setPortuguese(_ sender: Any) {
        Localize.setCurrentLanguage("pt-BR")
        updateLanguage()
    }
    
    @IBAction func setItalian(_ sender: Any) {
        Localize.setCurrentLanguage("it")
        updateLanguage()
    }
    
    func updateLanguage() {
        aboutLbl.text = "about".localized()
        languageLbl.text = "languageTitle".localized()
        generalAdjLabel.text = "settingGeneralAdj".localized()
        editProfileBtn.setTitle("editProfile".localized(), for: .normal)
    }
    
    @IBAction func changePrivacyProfile(_ sender: Any) {
        if privacyProfileSwitch.isOn {
            showAlert(title: "changePrivacyProfile".localized(), subtitle: "changePrivacyProfileMsgTrue".localized(), writeDB: false)
        } else {
            showAlert(title: "changePrivacyProfile".localized(), subtitle: "changePrivacyProfileMsgFalse".localized(), writeDB: false)
        }
    }
    
    @IBAction func changePrivacyFriendList(_ sender: Any) {
        if privacyFriendsSwitch.isOn {
            showAlert(title: "changePrivacyFriend".localized(), subtitle: "changePrivacyFriendMsgTrue".localized(), writeDB: false)
        } else {
            showAlert(title: "changePrivacyFriend".localized(), subtitle: "changePrivacyFriendMsgFalse".localized(), writeDB: false)
        }
    }
    
    @IBAction func changePrivacyLocation(_ sender: Any) {
        if privacyLocSwitch.isOn {
            showAlert(title: "changePrivacyLocation".localized(), subtitle: "changePrivacyLocationMsgTrue".localized(), writeDB: false)
        } else {
            showAlert(title: "changePrivacyLocation".localized(), subtitle: "changePrivacyLocationMsgFalse".localized(), writeDB: false)
        }
    }
    
    @IBAction func gotoEditProfile(_ sender: Any) {
        writeInDB()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func setProfileBtt(_ sender: Any) {
        showAlert(title: "editProfile".localized(), subtitle: "editProfileMsg".localized(), writeDB: true)
    }
    
    func showAlert(title: String, subtitle: String, writeDB: Bool) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        if writeDB {
            let cancelAction = UIAlertAction(title: "cancel".localized(), style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            
            if writeDB {
                self.writeInDB()
                let alertControllerInside = UIAlertController(title:"profileEdited".localized(), message: "profileEditedMsg".localized(), preferredStyle: .alert)
                let okBtn = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertControllerInside.addAction(okBtn)
                self.present(alertControllerInside, animated: true, completion: nil)
                
            }
        })
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func writeInDB() {
        userDefaults.set(userData, forKey: "user")
        userDefaults.synchronize()
        writeInUserDict(userData: userData)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        updateLanguage()
        
        textViewAbout.text = "Aranda Antonio\nBermúdez Pedro\nPrada Christian\nRamos Carlos"
        
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

