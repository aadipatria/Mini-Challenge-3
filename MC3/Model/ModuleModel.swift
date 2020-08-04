//
//  ModuleModel.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 27/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

enum Genre {
    case horror
    case adventure
    case action
    case spaceTravel
    case mystery
    case strategy
    case medieval
    case apocalyptic
}

enum ModuleLevel {
    case hard
    case normal
    case easy
}

struct ModuleModel:Identifiable{
    let id = UUID.init()
    var name:String
    var author:AuthorModel
    var coverImageName:String
    var addDate:Date
    var level:ModuleLevel
    var genre:Genre
    var content:ModuleContent
}
