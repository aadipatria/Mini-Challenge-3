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
                    environment: [EnvironmentModel(weather: "Cloudy", terrain: "Terraria", image: "OverviewSample", desc: "Most conventional modern houses")],
    //                traps: <#T##[Trap]?#>,
                    //maps: [
                        //Maps(name: "The Legacy", desc: "Most conventional modern houses", image: "OverviewSample")
                    //],
                    pois: [
                        POI(name: "The Legacy", desc: "Most conventional modern houses", image: "OverviewSample"),
                        POI(name: "The Legacy2", desc: "something something", image: "OverviewSample"),
                        POI(name: "The Legacy3", desc: "Mostly sample text modern houses", image: "OverviewSample")
                    ],
                    npcs: [
                        NPC(name: "Bobby", race: "Hill Dwarf", image: "RealBrad", desc: "Most conventional modern houses in Western cultures will contain one or more")
                    ],
                    monsters: [
                        Monster(name: "Adult Blue Dracholic", image: "RealBrad", size: "200", type: "Dragon", alignment: "Lawful Good", armorclass: "19", hitpoints: "225", speed: "40", strength: 25, dexterity: 10, constitution: 23, intelligence: 16, wisdom: 15, charisma: 19, desc: "Legendary Resistance (3/Day). If the dracolich fails a saving throw, it can choose to succeed instead. \nMagic Resistance. The dracolich has advantage on saving throws against spells and other magical effects.")
                    ],
                    readAloudText: [
                        ReadAloudText(name: "No Rules", desc: "desc1"),
                        ReadAloudText(name: "No Spells", desc: "desx1")
                    ],
                    treasure: [
                        Magic(name: "Amulet of Health", type: "Wondrous Item", rarity: "Legendary", maxCharge: "", weight: "", desc: "Your Constitution score is 19 while you wear this amulet. It has no effect on you if your Constitution is already 19 or higher."),
                        Coin(platinum: 0, gold: 5, emerald: 0, silver: 0, copper: 0),
                        Item(name: "Free Item", weight: "", quantity: "", cost: "Free", desc: "It's a free item, what else do you want? It does nothing, though")
                    ],
                    notes: [Notes(desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")]),
                Encounter(
                    name: "Spicy Potato",
                    location: "Emporium Side Lane",
                    environment: [EnvironmentModel(weather: "Cloudy", terrain: "Terraria", image: "OverviewLarge", desc: "in Western cultures will contain")],
    //                traps: <#T##[Trap]?#>,
                    maps: [
                        Maps(name: "The Legacy", desc: "Most conventional modern houses", image: "OverviewSample"),
                        Maps(name: "The Legacy 2", desc: "Unconventional modern houses", image: "OverviewSample")
                    ],
                    pois: [
                        POI(name: "The Legacy", desc: "Most conventional modern houses", image: "OverviewSample")
                    ],
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
                MainNotes(name: "No Spells", desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.")])
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
                username: "", profileImage: "RealBrad",
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
