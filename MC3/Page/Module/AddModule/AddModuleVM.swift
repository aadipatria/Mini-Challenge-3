//
//  AddModuleVM.swift
//  MC3
//
//  Created by Peter Andrew on 07/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import Foundation
import SwiftUI

struct AddModuleVM {
    var image:Image? = nil
    var moduleName:String = ""
    var indexlevel:Int? = nil
    var indexGenre:Int? = nil
    var currentInput:CurrAddModuleInput? = nil
    var isLevel:Bool = false
    var isGenre:Bool = false
}

enum CurrAddModuleInput {
    case level
    case genre
    case name
}

