//
//  EncounterTraps.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTraps: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].traps?.isEmpty ?? true {
                EncounterTrapsEdit(editMode: .add)
            } else {
                EncounterTrapsList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterTraps_Preview: PreviewProvider {
    static var previews: some View {
        EncounterTraps().environmentObject(ModuleInfo())
    }
}
