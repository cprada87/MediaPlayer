//
//  LiveListViewController.swift
//  MediaPlayer
//
//  Created by pedro on 14/9/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import Localize_Swift

class LiveListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var liveData:[[String:Any]]?
    var artistId:Int?
    var index: Int?
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var howToGoButton: UIButton!
    @IBOutlet weak var artistImageBackground: UIImageView!
    
    @IBAction func gotoMapDetailView(_ sender: Any) {
        if index != nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapDetailViewController") as! MapDetailViewController
            vc.data = liveData?[index!]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showNoSelectedCellAlert()
        }
    }
    
    @IBAction func buyTicket(_ sender: Any) {
        if index != nil {
            showAlert(title: "buyTicket".localized(), message: "buyTicketMsg".localized())
        } else {
            showNoSelectedCellAlert()
        }
    }
  
    func showNoSelectedCellAlert() {
        let alertController = UIAlertController(title: "noSelectedLiveCell".localized(), message: "noSelectedLiveCellMsg".localized(), preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler:{(action) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "yes".localized(), style: .default, handler:{(action) in
            let alertControllerInside = UIAlertController(title: "bought".localized(), message: "boughtMsg".localized(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alertControllerInside.addAction(okAction)
            self.present(alertControllerInside, animated: true, completion: nil)
        })
        let noAction = UIAlertAction(title: "no".localized(), style: .cancel, handler: nil)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(liveData!.count)
        return liveData!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell")!
        cell.textLabel?.text = liveData![indexPath.row]["city"] as? String
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let artist = getArtist(artistId: artistId!)
        
        artistImageBackground.image = UIImage(named: artist["image"] as! String)
        liveData = artist["lives"] as? [[String:Any]]
        
        buyButton.setTitle("buyButton".localized(), for: .normal)
        howToGoButton.setTitle("howToGoButton".localized(), for: .normal)
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
