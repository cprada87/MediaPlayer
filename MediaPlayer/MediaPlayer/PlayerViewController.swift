//
//  ReproductorViewController.swift
//  MediaPlayer
//
//  Created by pedro on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import UIKit
import AVFoundation
import Localize_Swift

class PlayerViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var artistBackgroundImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var albumBackgroundImage: UIImageView!
    @IBOutlet weak var currentTimeLbl: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var artistAlbumName: UITextView!
    @IBOutlet weak var beforeSong: UIImageView!
    @IBOutlet weak var stopMusic: UIImageView!
    @IBOutlet weak var playPauseMusic: UIImageView!
    @IBOutlet weak var nextSong: UIImageView!
    @IBOutlet weak var volumenUp: UIImageView!
    @IBOutlet weak var volumenDown: UIImageView!
    @IBOutlet weak var volumenSlider: UISlider!
    
    
    var index = 0
    
    let audioPlayer = AVPlayer()
    var isPlaying:Bool = false
    
    var musicList = [[String:Any]]()
    
    var userData = [String:Any]()
    
    let dateComponentsFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        return formatter
    }()
    
    
    // MARK: - Music Control
    @IBAction func playPauseMusic(_ recognizer: UITapGestureRecognizer) {
        if isPlaying {
            playPauseMusic.image = UIImage(named: "play")
            audioPlayer.pause()
        } else {
            playPauseMusic.image = UIImage(named: "pause")
            audioPlayer.play()
        }
        isPlaying = !isPlaying
    }
    
    @IBAction func stopMusic(_ recognizer: UITapGestureRecognizer) {
        let time:CMTime = CMTimeMake(0, 1)
        audioPlayer.seek(to: time)
        audioPlayer.pause()
        isPlaying = false
        playPauseMusic.image = UIImage(named: "play")
    }
    
    
    @IBAction func nextMusic(_ recognizer: UITapGestureRecognizer) {
        playNextSong()
    }
    
    @IBAction func beforeMusic(_ recognizer: UITapGestureRecognizer) {
        if index > 0 {
            index -= 1
        } else {
            index = musicList.count - 1
        }
        setUpAudioPlayer()
    }
    
    @IBAction func volumenUp(_ recognizer: UITapGestureRecognizer) {
        if audioPlayer.volume <= 1 {
            audioPlayer.volume += 0.1
            volumenSlider.value = audioPlayer.volume
        }
    }
    
    @IBAction func volumenDown(_ recognizer: UITapGestureRecognizer) {
        if audioPlayer.volume > 0.0 {
            audioPlayer.volume -= 0.1
            volumenSlider.value = audioPlayer.volume
        } else {
            volumenSlider.value = 0.0
            audioPlayer.volume = volumenSlider.value
        }
    }
    
    @IBAction func changeVolumen(_ sender: Any) {
        audioPlayer.volume = volumenSlider.value
    }
    
    @IBAction func newTime(_ sender: Any) {
        let seconds:Int64 = Int64(currentTimeSlider.value)
        
        let seekTime:CMTime = CMTimeMake(seconds, 1)
        audioPlayer.seek(to: seekTime)
    }
    
    func playNextSong() {
        if index < musicList.count - 1 	{
            index += 1
        } else {
            index = 0
        }
        setUpAudioPlayer()
    }
    
    func setUpAudioPlayer() {
        let artistDic = musicList[index]["artist"] as! Dictionary<String, Any>
        let artistName = "\(artistDic["name"]!)"
        let musicName = "\(musicList[index]["title"]!)"
        let album = musicList[index]["album"] as! [String:Any]
        let navTitle = "\(artistName) - \(musicName)"
        let userFavs = userData["favs"] as! [Int]
        print("indice: \(index) - \(musicList[index]))")
        artistBackgroundImage.image = UIImage(named: artistDic["image"] as! String)
        albumBackgroundImage.image = UIImage(named: album["image"] as! String)
        artistAlbumName.text = navTitle
        artistAlbumName.isEditable = false
        self.navigationItem.title = navTitle
        
        
        if userFavs.contains(musicList[index]["id"] as! Int) {
            favoriteImage.image = UIImage(named: "favorite")
        } else {
            favoriteImage.image = UIImage(named: "noFavorite")
        }
        
        let audioFileURL = Bundle.main.url(forResource: musicList[index]["file"] as! String, withExtension: "mp3")!
        let asset = AVURLAsset(url: audioFileURL, options: nil)
        let playerItem = AVPlayerItem(asset: asset)
        audioPlayer.replaceCurrentItem(with: playerItem)
        
        //Slider
        let duration:CMTime = playerItem.asset.duration
        let seconds:Float64 = CMTimeGetSeconds(duration)
        
        currentTimeSlider.minimumValue = 0
        currentTimeSlider.maximumValue = Float(seconds)
        currentTimeSlider.isContinuous = true
        currentTimeSlider.tintColor = .green
        
        totalTime.text = secondsFormatter(intSeconds: seconds)
        audioPlayer.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 4), queue: DispatchQueue.main, using: {[weak self] time in
            let seconds = CMTimeGetSeconds(time)
            self?.updatePlayer(withCurrentTime: CGFloat(seconds))
        })

    }
    
    func secondsFormatter(intSeconds: Double) -> String {
        let mins:Int = Int(intSeconds)/60
        let secs:Int = Int(intSeconds) % 60
        let minsStr = ((mins < 10 ? "0" : "") + String(mins))
        let secsStr = ((secs < 10 ? "0" : "") + String(secs))
        let strTimestamp = minsStr + ":" + secsStr
        
        return strTimestamp
    }
    
    func updatePlayer(withCurrentTime currentTime: CGFloat) {
        var components = DateComponents()
        components.second = Int(currentTime)
        currentTimeSlider.value = Float(Int64(currentTime))
        currentTimeLbl.text = "\(dateComponentsFormatter.string(from: components)!)"
        let durationInt:Int = Int(CMTimeGetSeconds((audioPlayer.currentItem?.asset.duration)!))
        let currentTimeInt:Int = Int(CMTimeGetSeconds((audioPlayer.currentItem?.currentTime())!))
        components.second = durationInt - currentTimeInt
        totalTime.text = "\(dateComponentsFormatter.string(from: components)!)"
        if durationInt <= currentTimeInt {
            playNextSong()
        }
    }
    
    // MARK: -
    @IBAction func infoArtist(_ recognizer: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArtistDetailViewController") as! ArtistDetailViewController
        vc.artistId = index
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addFavorite(_ recognizer: UITapGestureRecognizer) {
        var userFavIds = userData["favs"] as! [Int]
        let currentMusicId = musicList[index]["id"] as! Int
        
        if userFavIds.contains(currentMusicId) {
            var index = 0
            while index < userFavIds.count {
                if userFavIds[index] == currentMusicId {
                    userFavIds.remove(at: index)
                    break
                }
                index += 1
            }
            favoriteImage.image = UIImage(named: "noFavorite")
        } else {
            userFavIds.append(currentMusicId)
            favoriteImage.image = UIImage(named: "favorite")
        }
        
        userData["favs"] = userFavIds
        writeInUserDict(userData: userData)

        userDefaults.set(userData, forKey: "user")
        userDefaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nrepresentation:\(userDefaults.dictionaryRepresentation())\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        if userDefaults.object(forKey: "user") != nil {
            userData = userDefaults.object(forKey: "user") as! [String:Any]
            
        }

        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nMusicList:\(musicList)\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
        
        volumenSlider.maximumValue = 1.0
        volumenSlider.minimumValue = 0.0
        volumenSlider.setValue(0.5, animated: true)
        audioPlayer.volume = volumenSlider.value
        
        
        if musicList.count > 0 {
            setUpAudioPlayer()
        } else {
            let alertController = UIAlertController(title: "noMusic".localized(), message: "noMusicMsg".localized(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
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
