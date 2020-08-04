//
//  AuthorModel.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 01/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct AuthorModel {
    let id:UUID = UUID.init()
    var name:String
    var image: String
    var username:String
    var password:String
    var email:String
    var phone:String
    var youtube:String = ""
    var instagram:String = ""
    var discord:String = ""
    var whatsapp:String = ""
    var facebook:String = ""
    var line:String = ""
}

