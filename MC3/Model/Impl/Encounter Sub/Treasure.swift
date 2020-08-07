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
    var damage:String
    var magicModifier:String
    var type:String
    var handedness:String
    var proficiency:String
    var price:String
    var weight:String
    var range:String
    var damageType:String
    var property:String
    var quantity:String
    var desc:String
}

struct Magic: Treasure {
    var treasureType:TreasureType = .magic
    var id:UUID = UUID.init()
    var name:String
    var type:String
    var rarity:String
    var maxCharge:String
    var weight:String
    var desc:String
}

struct Item: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .item
    var name: String
    var weight: String
    var quantity: String
    var cost: String
    var desc: String    
}

struct Coin: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .coin
    var platinum: Int
    var gold: Int
    var emerald: Int
    var silver: Int
    var copper: Int
}

struct Armor: Treasure {
    var id: UUID = UUID.init()
    var treasureType: TreasureType = .armor
    var name :String
    var type :String
    var magicModifier :String
    var price :String
    var weight :String
    var armorClass :String
    var stealth :String
    var desc :String
}
