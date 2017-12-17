//  EditarPerfilViewController.swift
//  MediaPlayer
//
//  Created by Christian on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UIPopoverControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageProfileButton: UIButton!
    @IBOutlet weak var imageProfileView: UIImageView!
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var userProfileTxF: UITextField!
    @IBOutlet weak var passwdProfileTxf: UITextField!
    
    @IBOutlet weak var aboutProfileTextView: UITextView!
    
    @IBOutlet weak var subscribeProLabel: UILabel!
    
    var pickedPicture = false
    var filePath:String?
    
    // todo revisar el guardado y hacerlo en el resto donde se use
    var userData = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = userDefaults.object(forKey: "user") as! [String:Any]
        editProfileLabel.text = "editProfileLbl".localized()
        
        imageProfileButton.titleLabel?.text = "editImageProfileLbl".localized()
        userProfileTxF.text = userData["username"] as! String
        passwdProfileTxf.isSecureTextEntry = true
        if userData["imgFile"] != nil {
            imageProfileView.image = UIImage(contentsOfFile: userData["imgFile"] as! String)
        } else {
            imageProfileView.image = UIImage(named: userData["image"] as! String)
        }
        // Do any additional setup after loading the view.
    }
    
    
    // Abrir Carrete
    @IBAction func openLibrary(_ sender: Any) {
        openGallary()
    }
    
    func openGallary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            pickedPicture = true
            imageProfileView.contentMode = .scaleAspectFit
            imageProfileView.image = chosenImage
            dismiss(animated: true, completion: nil)
        } else {
            pickedPicture = false
            if userData["imgFile"] != nil {
                imageProfileView.image = UIImage(contentsOfFile: userData["imgFile"] as! String)
            } else {
                imageProfileView.image = UIImage(named: userData["image"] as! String)
            }
        }
    }
    
    @IBAction func saveSettings(_ sender: Any) {
        if (userProfileTxF.text?.isEmpty)! {
            showAlert(title: "userNeeded".localized(), subtitle: "userNeededMsg".localized())
        } else if checkUsername(username: userProfileTxF.text!)  && userProfileTxF.text! != userData["username"] as! String 	{
            showAlert(title: "userExists".localized(), subtitle: "userExists".localized())
        } else {
            if pickedPicture {
                //SAVE IMAGE IN PHOTOLIBRARY
                let imageData = UIImageJPEGRepresentation(imageProfileView.image!, 0.6)
                let compressedJPGImage = UIImage(data: imageData!)
                UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
            
            
                //SAVE PHOTO IN APP
                let fileManager = FileManager.default
                let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("myPhoto.jpg")
            
                let imageRep = UIImageJPEGRepresentation(imageProfileView.image!, 0.6)
            
                fileManager.createFile(atPath: paths as String, contents: imageRep, attributes: nil)
            
                userData["imgFile"] = paths
                print("\n\n\n\n\n\n\n\nPath: \(userData["imgFile"])\n\n\n\n\n\n")
                imageProfileView.image = UIImage(contentsOfFile: userData["imgFile"] as! String)
            }
            userData["username"] = userProfileTxF.text
            
            if (passwdProfileTxf.text?.isNotEmpty)! {
                userData["pass"] = passwdProfileTxf.text
            }
            
            userDefaults.set(userData, forKey: "user")
            userDefaults.synchronize()
            
            writeInUserDict(userData: userData)
            showAlert(title: "profileEdited".localized(), subtitle: "profileEditedMsg".localized())
        }
    }
    
    func showAlert(title: String, subtitle: String) {
        let alertController = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func cancelSettings(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
