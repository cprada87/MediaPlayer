//
//  UserTools.swift
//  MediaPlayer
//
//  Created by pedro on 15/9/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation


var userDict:[[String:Any]] = [
    ["id":0, "username":"username1", "favs":[0,1,2], "age":23, "mail":"mail1@email.com", "pass":"123456", "image":"avatar1", "latitude":20.0, "longitude":20.0, "friends":[1,2], "description":"Descrition"],
    ["id":1, "username":"username2", "favs":[0,7,10], "age":21, "mail":"mail2@email.com", "pass":"123456", "image":"avatar1", "latitude":20.0, "longitude":20.0, "friends":[0], "description":"Descrition"],
    ["id":2, "username":"username3", "favs":[20,14,6], "age":25, "mail":"mail3@email.com", "pass":"123456", "image":"avatar1", "latitude":20.0, "longitude":20.0, "friends":[0], "description":"Descrition"]
]

func writeInUserDict(userData: [String:Any]) {
    var index = 0
    while index < userDict.count{
        if userDict[index]["id"] as! Int == userData["id"] as! Int {
            userDict[index] = userData
            break
        }
        index += 1
    }
    userDefaults.set(userDict, forKey: "users")
}

func getUser(username: String, password: String) -> [String:Any] {
    
    for user in userDict {
        if (user["username"] as! String) == username && (user["pass"] as! String) == password {
            return user
        }
    }
    
    return [:]
}

func checkUsername(username: String) -> Bool{
    for user in userDict {
        if user["username"] as! String == username {
            return true
        }
    }
    return false
}

func checkPassword(password: String) -> Bool{
    for user in userDict {
        if user["pass"] as! String == password {
            return true
        }
    }
    return false
}

func checkEmail(email: String) -> Bool {
    for user in userDict {
        if user["mail"] as! String == email {
            return true
        }
    }
    return false
}
