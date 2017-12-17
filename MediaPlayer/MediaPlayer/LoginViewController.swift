//
//  LoginViewController.swift
//  MediaPlayer
//
//  Created by Christian on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var avatarImgView: UIImageView!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTxF: UITextField!
    
    @IBOutlet weak var passwdLabel: UILabel!
    @IBOutlet weak var passwordTxF: UITextField!
    @IBOutlet weak var forgotPasswdBtt: UIButton!
    @IBOutlet weak var loginEnterBtt: UIButton!
    @IBOutlet weak var newLabel: UILabel!
    
    @IBOutlet weak var registerBtt: UIButton!
    
    var userReceived: String?
    var passwdReceived: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if userDefaults.object(forKey: "user") != nil {
            goToMain()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.object(forKey: "user") != nil {
            goToMain()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefaults.object(forKey: "user") == nil{
            if userReceived != nil && validateNewUser?[userReceived!]! != nil {
                userTxF.text = validateNewUser?[userReceived!]?.username
                passwordTxF.text = validateNewUser?[userReceived!]?.password
            } else if validateNewUser?.first != nil {
                userTxF.text = validateNewUser?.first?.value.username
                passwordTxF.text = validateNewUser?.first?.value.password
            }
        } else {
            goToMain()
        }
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - LANGUAGES METHODS INIT
    
    func updateItemLanguagues() {
        imageBackground.image = UIImage(named: "concierto")
        avatarImgView.image = UIImage(named: "imgLogo".localized())
        userLabel.text = "username".localized()
        userTxF.placeholder = "Put your Username here".localized()
        passwdLabel.text = "password".localized()
        passwordTxF.placeholder = "Put your Password here".localized()
        loginEnterBtt.setTitle("enter".localized(), for: .normal)
        forgotPasswdBtt.setTitle("enter".localized(), for: .normal)
        newLabel.text = "areYouNew".localized()
        registerBtt.setTitle("register".localized(), for: .normal)
        
    }
    
    //MARK: - LOGIN TOOLS
    
    @IBAction func loginBtt(_ sender: Any) {
        form()
    }
    
    func form() {
        var validateForm = true
        
        if (userTxF.text?.isEmpty)! {
            // userNeeded = Usuario necesario
            // userNeededMsg = Necesitamos un nombre de usuario
            // wrongUser = Usuario incorrecto
            // wrongUserMsg = El nombre de usuario no coincide
            // passNeeded = Contraseña necesaria
            // passNeededMsg = No te olvides de escribir la Contraseña
            // wrongPass = Confirmar contraseña
            // wrongPassMsg = Escribe la contraseña de nuevo
            
            showAlert(title: "userNeeded".localized(), message: "userNeededMsg".localized(), option: -1)
            validateForm = false
        }
        else if !checkUsername(username: userTxF.text!) {
            print("chenUserName")
            showAlert(title: "wrongUser".localized(), message: "wrongUserMsg".localized(), option: 0)
            validateForm = false
        }
        else if (passwordTxF.text?.isEmpty)! {
            showAlert(title: "passNeeded".localized(), message: "passNeededMsg".localized(), option: -1)
            validateForm = false
        }
        else if !checkPassword(password: passwordTxF.text!) {
            showAlert(title: "wrongPass".localized(), message: "wrongPassMsg".localized(), option: 1)
            validateForm = false
        }
        if validateForm {
            goToMain()
        }
    }
    
    
    //MARK: - EXCEPTIONS

    func showAlert(title: String, message: String, option: Int) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        switch option {
        case 0:
            print("case 0")
            var myTextField: UITextField?
            alertController.addTextField(configurationHandler:{ (textfield) -> Void in
                myTextField = textfield
                
            })
            let okAction = UIAlertAction(title: "ok", style: .default, handler: {(action) in
                self.userTxF.text = myTextField?.text
                self.form()
            })
            alertController.addAction(okAction)
            
        case 1:
            var myTextField: UITextField?
            alertController.addTextField(configurationHandler:{ (textfield) -> Void in
                myTextField = textfield
                
            })
            let okAction = UIAlertAction(title: "ok", style: .default, handler: {(action) in
                self.passwordTxF.text = myTextField?.text
                self.form()
            })
            alertController.addAction(okAction)
        default:
            let okAction = UIAlertAction(title: "ok", style: .default, handler: {(action) in print("OK")})
            alertController.addAction(okAction)
            
        }
        self.present(alertController, animated: true, completion: nil)
        
    }

    
    @IBAction func dismissKeyboard(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation Tools
    
    @IBAction func goToRegister(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
        vc?.modalPresentationStyle = .popover
        self.navigationController?.pushViewController(vc!, animated: true)
        vc?.popoverPresentationController?.sourceView = view
        vc?.popoverPresentationController?.sourceRect = registerBtt.layer.frame
    }
    
    
    @IBAction func goToForgot() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as? ForgotPasswordViewController
        vc?.modalTransitionStyle = .crossDissolve
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func goToMain() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTab") as? UITabBarController
        let userData = getUser(username: userTxF.text!, password: passwordTxF.text!)
        if userDefaults.object(forKey: "user") == nil {
            userDefaults.set(userData, forKey: "user")
            userDefaults.synchronize()
            userDefaults.set(userDict, forKey: "users")
            userDefaults.synchronize()
        }
        self.present(vc!, animated: true, completion: nil)
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
