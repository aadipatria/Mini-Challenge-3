//
//  Monster.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation
import SwiftUI

struct Monster: Model {
    var id:UUID = UUID.init()
    var name:String
    var image:UIImage
    var size:String
    var type:String
    var alignment:String
    var armorclass:String
    var hitpoints:String
    var speed:String
    var strength:Int
    var dexterity:Int
    var constitution:Int
    var intelligence:Int
    var wisdom:Int
    var charisma:Int
    var desc:String
}
