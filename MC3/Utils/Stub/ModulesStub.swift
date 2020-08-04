//
//  ModulesStub.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import Foundation

class ModulesStub {
    
    static var modulContent = [
        ModuleContent(overviews: [], encounters: [], notes: []),
        ModuleContent(overviews: [], encounters: [], notes: []),
        ModuleContent(overviews: [], encounters: [], notes: []),
        ModuleContent(overviews: [], encounters: [], notes: []),
        ModuleContent(
            overviews: [Overview(
                name: "The Legacy",
                image: "OverviewSample",
                desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")],
            encounters: [
                Encounter(
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
                    notes: []),
                Encounter(
                    name: "Spicy Potato",
                    location: "Emporium Side Lane",
    //                environment: <#T##[EncounterEnvironment]?#>,
    //                traps: <#T##[Trap]?#>,
    //                maps: <#T##[Maps]?#>,
    //                pois: <#T##[POI]?#>,
    //                npcs: <#T##[NPC]?#>,
    //                monsters: <#T##[Monster]?#>,
                    readAloudText: [
                        ReadAloudText(name: "No Way", desc: "desc1"),
                        ReadAloudText(name: "Go Way", desc: "desx1")
                    ],
    //                treasure: <#T##[Treasure]?#>,
                    notes: []),
            ],
            notes: [
                MainNotes(name: "No Rules", desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room."),
                MainNotes(name: "No Rules", desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")])
    ]
    
    static var modulModel = [
        ModuleModel(name: "Dummy", author: AuthorStub.getActiveUser()
            , coverImageName: "moduleCover", addDate: Date.init(), level: .hard, genre: .action, content: ModulesStub.modulContent[0]),
        ModuleModel(name: "Dummy", author: AuthorStub.getActiveUser()
        , coverImageName: "moduleCover", addDate: Date.init(), level: .hard, genre: .medieval, content: ModulesStub.modulContent[1]),
        ModuleModel(name: "Dragons' Champion", author: AuthorStub.getActiveUser()
        , coverImageName: "people", addDate: Date.init(), level: .easy, genre: .strategy, content: ModulesStub.modulContent[2]),
        ModuleModel(name: "Modelina View", author: AuthorStub.getActiveUser()
        , coverImageName: "archer", addDate: Date.init(),level: .normal, genre: .horror, content: ModulesStub.modulContent[3]),
        ModuleModel(
            name: "Legacy of Blood",
            author: AuthorModel(
                name: "Real Brad",
                image: "RealBrad",
                username: "",
                password: "",
                email: "",
                phone: ""),
            coverImageName: "RealBrad",
            addDate: Date(timeIntervalSince1970: 999999),
            level: .normal,
            genre: .adventure,
            content: ModulesStub.modulContent[4])
    ]
    
    static func getModules()->[ModuleModel]{
        return modulModel
    }
    
    static func fetchModules(completion: @escaping ([ModuleModel]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // fetch from a web api and then populate the Post array
            let modules = ModulesStub.getModules()
            
            completion(modules)
        }
    }
    
    
    static func getPlainModule()->ModuleModel {
        return ModuleModel(name: "", author: AuthorStub.getActiveUser(), coverImageName: "", addDate: Date.init(),level: .normal, genre: .horror, content: ModulesStub.modulContent[0])
    }
}
