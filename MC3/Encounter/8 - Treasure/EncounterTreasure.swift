//
//  EncounterTreasure.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTreasure: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].treasure?.isEmpty ?? true {
                EncounterTreasureEdit(editMode: .add)
            } else {
                EncounterTreasureList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterTreasure_Preview: PreviewProvider {
    static var previews: some View {
        EncounterTreasure().environmentObject(ModuleInfo())
    }
}

