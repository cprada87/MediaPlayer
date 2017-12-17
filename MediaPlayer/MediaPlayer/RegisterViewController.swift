//
//  RegisterViewController.swift
//  MediaPlayer
//
//  Created by Christian on 23/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userTxF: UITextField!
    
    @IBOutlet weak var passwdLabel: UILabel!
    @IBOutlet weak var passwdTxF: UITextField!
    
    @IBOutlet weak var rePlayPasswdLabel: UILabel!
    @IBOutlet weak var rePlayPasswdTxF: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTxF: UITextField!
    
    @IBOutlet weak var receiveNewsletterSwt: UISwitch!
    
    @IBOutlet weak var registerBtt: UIButton!
    @IBOutlet weak var cancelBtt: UIButton!
    
    @IBOutlet weak var imageBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // Creación de un usuario dado el constructor
    func createUser() {
        if userDefaults.object(forKey: "users") != nil {
            userDict = userDefaults.object(forKey: "users") as! [[String:Any]]
        }
        let newUser = NewUser(username: userTxF.text!,
                              password: passwdTxF.text!,
                              email: emailTxF.text!,
                              receiveNewsletter: String(receiveNewsletterSwt.isOn))
        let userId = userDict.count
        let userFavs = [Int]()
        let userFriends = [Int]()
        let userDictTmp:[String : Any] = ["id": userId, "username":userTxF.text!, "pass":passwdTxF.text!, "mail":emailTxF.text!, "image":"avatar1", "favs":userFavs, "friends":userFriends, "latitude":20.0, "longitude":20.0]
        userDict.append(userDictTmp)
        
        userDefaults.set(userDict, forKey: "users")
        
        userDefaults.synchronize()
        print("data saved")
        
        validateNewUser?.updateValue(newUser, forKey: userTxF.text!)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{ (action) in alertController.dismiss(animated: true, completion: nil)})
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Validaciones registro de nuevo usuario
    @IBAction func registerNewUser(_ sender: Any) {
        var allDone = true
        
        // "userExists"="Usuario ya creado";
        // "userExistsMsg"="El Usuario ya esta registrado";
        // "usernameRegistered"="Nombre de usuario registrado";
        // "usernameRegisteredMsg"="El nombre de usuario se encuentra registrado. Por favor seleccione otro";
        // "rePassword"="Confirmar contraseña";
        // "rePasswordMsg"="Escribe la Contraseña de nuevo";
        // "passRePassDifferent"="Error de contraseñas";
        // "passRePassDifferentMsg"="Una de las Contraseñas no coincide, revisalas de nuevo";
        // "emailNeeded"="Email necesario";
        // "emailNeededMsg"="Necesitamos un Correo Electrónico";
        // "emailExists"="Error de contraseñas";
        // "emailExistsMsg"="Una de las Contraseñas no coincide, revisalas de nuevo";
        
//        if validateNewUser?[userTxF.text!] != nil {
//            allDone = false
//            showAlert(title: "Usuario ya creado", message: "El Usuario ya esta registrado")
//        }
        
        if userTxF.text!.isEmpty {
            allDone = false
            showAlert(title: "userNeeded".localized(),
                      message: "userNeededMsg".localized())
        }
            
        else if checkUsername(username: userTxF.text!) {
            allDone = false
            showAlert(title: "usernameRegistered".localized(),
                      message: "usernameRegisteredMsg".localized())
        }
        
        else if passwdTxF.text!.isEmpty {
            allDone = false
            showAlert(title: "passNeeded".localized(),
                      message: "passNeeded".localized())
        }
        else if rePlayPasswdTxF.text!.isEmpty {
            allDone = false
            showAlert(title: "rePassword".localized(), message: "rePasswordMsg".localized())
        }
        else if passwdTxF.text != rePlayPasswdTxF.text {
            allDone = false
            showAlert(title: "passRePassDifferent".localized(),
                      message: "passRePassDifferentMsg".localized())
        }
        else if (emailTxF.text?.isEmpty)! {
            allDone = false
            showAlert(title: "emailNeeded".localized(), message: "emailNeededMsg".localized())
        }
        else if checkEmail(email: emailTxF.text!) {
            allDone = false
            showAlert(title: "emailExists".localized(),
                      message: "emailExistsMsg".localized())
        }
        // Llamada a "LoginViewController" listando los datos del nuevo registro
        if allDone {
            createUser()
            let vc = self.storyboard?.instantiateViewController(
                withIdentifier: "LoginViewController") as? LoginViewController
            vc?.userReceived = userTxF.text
            vc?.passwdReceived = passwdTxF.text
            present(vc!, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelRegister(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(
            withIdentifier: "LoginViewController") as? LoginViewController
        present(vc!, animated: true, completion: nil)
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
