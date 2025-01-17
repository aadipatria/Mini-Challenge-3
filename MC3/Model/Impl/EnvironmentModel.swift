//
//  Environment.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation
import SwiftUI

struct EnvironmentModel: Model {
    var id: UUID = UUID.init()
    var weather:String
    var terrain:String
    var image:URL
    var desc:String
}
