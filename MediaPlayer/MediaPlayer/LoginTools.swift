//
//  login.swift
//  MediaPlayer
//
//  Created by Christian on 22/8/17.
//  Copyright © 2017 com.company. All rights reserved.
//

import Foundation

// initial user validation

let validateUser = ["username":"usuario", "password":"1234"]

// Constructor new user

struct NewUser {
    var username: String
    var password: String
    var email: String
    var receiveNewsletter: String
    
    init(username: String, password: String, email: String, receiveNewsletter: String) {
        self.username = username
        self.password = password
        self.email = email
        self.receiveNewsletter = receiveNewsletter
    }
}
var validateNewUser: [String:NewUser]? = [:]
