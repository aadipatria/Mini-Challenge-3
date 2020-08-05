//
//  Monster.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct Monster: Model {
    var id:UUID = UUID.init()
    var name:String
    var image:String
    var size:Int
    var type:String
    var alignment:String
    var armorclass:String
    var hitpoints:Int
    var speed:Int
    var strength:Int
    var dexterity:Int
    var constitution:Int
    var intelligence:Int
    var wisdom:Int
    var charisma:Int
    var desc:String
}
