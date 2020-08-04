//
//  Encounter.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

struct Encounter: Model {
    var id: UUID = UUID.init()
    var name: String
    var location: String
    var environment:[EncounterEnvironment]?
    var traps:[Trap]?
    var maps: [Maps]?
    var pois:[POI]?
    var npcs:[NPC]?
    var monsters:[Monster]?
    var readAloudText:[ReadAloudText]?
    var treasure:[Treasure]?
    var notes:[EncounterNotes]?
}
