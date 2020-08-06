//
//  ModuleContent.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct ModuleContent:Model {
    var id: UUID = UUID.init()
    var overviews:[Overview] = []
    var encounters:[Encounter] = []
    var notes:[MainNotes] = []
}
