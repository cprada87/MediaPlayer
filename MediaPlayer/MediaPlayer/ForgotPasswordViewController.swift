//
//  ForgotPasswordViewController.swift
//  MediaPlayer
//
//  Created by Christian on 23/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var forgotPassBtn: UIButton!
    
    
    @IBAction func forgotPassBtnAction(_ sender: Any) {
        showMessage()
    }
    
    func showMessage() {
        if checkEmail(email: emailTxtField.text!) {
            showAlert(title: "checkEmail".localized(), msg: "checkEmailMsg".localized(), exists: true)
        } else {
            showAlert(title: "wrongEmail".localized(), msg: "wrongEmailMsg".localized(), exists: false)
        }
    }
    
    func gotoLogin() {
        print("hola")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert(title: String, msg: String, exists: Bool) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
            if exists {
                self.gotoLogin()
            }
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBackground.image = UIImage(named: "concierto")
        
    }
    
    @IBAction func dismissKeyboard(){
        view.endEditing(true)
        
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
