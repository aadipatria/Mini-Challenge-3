//
//  MapNImage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct Maps: Model {
    var id: UUID = UUID.init()
    var name:String
    var desc:String
    var image:String
}

