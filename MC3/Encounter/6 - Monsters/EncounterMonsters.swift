//
//  EncounterMonsters.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMonsters: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].monsters?.isEmpty ?? true {
                EncounterMonstersEdit(editMode: .add)
            } else {
                EncounterMonstersList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterMonsters_Preview: PreviewProvider {
    static var previews: some View {
        EncounterMonsters().environmentObject(ModuleInfo())
    }
}
