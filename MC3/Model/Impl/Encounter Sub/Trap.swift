//
//  Trap.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct Trap: Model {
    var id: UUID = UUID.init()
    var name:String
    var desc:String
    var level:Int
    var threat:String
    var trigger:String
    var effect:String
    var counterMeasure:String
}





