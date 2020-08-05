//
//  EncounterNPC.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNPC: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].npcs?.isEmpty ?? true {
                EncounterNPCEdit(editMode: .add)
            } else {
                EncounterNPCList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterNPC_Preview: PreviewProvider {
    static var previews: some View {
        EncounterNPC().environmentObject(ModuleInfo())
    }
}
