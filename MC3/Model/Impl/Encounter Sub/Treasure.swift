//
//  Treasure.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

enum TreasureType {
    case weapon
    case magic
    case item
    case coin
    case armor
}

protocol Treasure {
    var id:UUID { get set }
    var treasureType:TreasureType {get set}
}

struct Weapon: Treasure {
    var treasureType:TreasureType = .weapon
    var id:UUID = UUID.init()
    var name:String
    var damage:Int
    var magicModifier:String
    var type:String
    var handedness:String
    var proficiency:String
    var price:Int
    var weight:Int
    var range:Int
    var damageType:String
    var property:String
    var quantity:Int
    var desc:String
}

struct Magic: Treasure {
    var treasureType:TreasureType = .magic
    var id:UUID = UUID.init()
    var name:String
    var type:String
    var rarity:String
    var maxCharge:Int
    var weight:Int
    var desc:String
}

struct Item: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .item
    var name: String
    var weight: Int
    var quantity: Int
    var desc: String

    
}

struct Coin: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .coin
    var platinum: Int
    var gold: Int
    var emerald: Int
    var silver: Int
    var cooper: Int
}

struct Armor: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .armor
    var name :String
    var type :String
    var magicmodifier :String
    var price :Int
    var weight :Int
    var armorclass :String
    var stealth :Int
    var desc :String
}
