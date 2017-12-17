//
//  Tools.swift
//  MediaPlayer
//
//  Created by pedro on 25/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation

var c = false
var jsonObject:Array<[String:Any]> = []
var userDefaults = UserDefaults.standard

func getJson(urlString: String) {
    if !c {
        c = true
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!, completionHandler:{(data, response, error) -> Void in
            if error != nil {
                print("No url found error: \(String(describing: error))")
                jsonObject.append(["error":"Error getting json"])
            } else {
                if let jsonResult = try?
                    JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) {
                    jsonObject = jsonResult as! Array<[String:Any]>
                } else {
                    jsonObject.append(["error": "Error getting json"])
                }
            }
        })
        task.resume()
    }
}
