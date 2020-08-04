//
//  UserSettings.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 01/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

class ModuleInfo: ObservableObject {
    @Published var moduleName: String = "Legacy of Blood"
    @Published var moduleAuthor: String = "Real Brad"
    @Published var authorImage: String = "RealBrad"
    
    @Published var currentModule: ModuleModel = ModulesStub.modulModel[4]
    
//    environments: [EncounterEnvironment(
//    desc: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.\nMost conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.",
//    weather: "Cloudy",
//    image: "OverviewLarge",
//    terrain: "Terraria")],
    
    public static func endEditing() {
        UIApplication.shared.endEditing()
    }
}
