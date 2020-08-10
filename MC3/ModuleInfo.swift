//
//  UserSettings.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 01/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

class ModuleInfo: ObservableObject {
    @Published var currentModule: ModuleModel
    
    @Published var overviewIndex: Int
    @Published var encounterIndex: Int
    @Published var mainNoteIndex: Int
    
    @Published var environmentIndex: Int
    @Published var trapIndex: Int
    @Published var mapsIndex: Int
    @Published var poiIndex: Int
    @Published var npcIndex: Int
    @Published var monsterIndex: Int
    @Published var ratIndex: Int
    @Published var treasureIndex: Int
    @Published var noteIndex: Int
    @Published var isLogin:Bool = false
    
    
    init() {
        self.currentModule = ModulesStub.modulModel.last ?? ModuleModel(
                    name: "Legacy of Blood",
                    author: AuthorModel(
                        name: "Real Brad",
                        username: "", profileImage: "Real Brad",
                        password: "",
                        email: "",
                        phone: ""),
                    coverImageName: "RealBrad",
                    addDate: Date(timeIntervalSince1970: 999999),
                    level: .normal,
                    genre: .adventure,
                    content:
                ModuleContent(
                    overviews: [Overview(
                        name: "The Legacy",
                        image: UIImage(named: "OverviewSample")!,
                        desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")],
                    encounters: [Encounter(
                        name: "Red Blanket",
                        location: "Imperial Sanctuary",
        //                environment: <#T##[EncounterEnvironment]?#>,
        //                traps: <#T##[Trap]?#>,
        //                maps: <#T##[Maps]?#>,
        //                pois: <#T##[POI]?#>,
        //                npcs: <#T##[NPC]?#>,
        //                monsters: <#T##[Monster]?#>,
                        readAloudText: [
                            ReadAloudText(name: "No Rules", desc: "desc1"),
                            ReadAloudText(name: "No Spells", desc: "desx1")
                        ],
        //                treasure: <#T##[Treasure]?#>,
                        notes: [])
                    ],
                    notes: [
                        MainNotes(name: "No Rules", desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room."),
                        MainNotes(name: "No Rules", desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")])
            )
        
        self.overviewIndex = 0
        self.encounterIndex = 0
        self.mainNoteIndex = 0
        
        self.environmentIndex = 0
        self.trapIndex = 0
        self.mapsIndex = 0
        self.poiIndex = 0
        self.npcIndex = 0
        self.monsterIndex = 0
        self.ratIndex = 0
        self.treasureIndex = 0
        self.noteIndex = 0
    }
    
    public static func endEditing() {
        UIApplication.shared.endEditing()
    }
}
