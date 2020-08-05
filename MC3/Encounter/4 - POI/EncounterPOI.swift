//
//  EncounterPOI.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterPOI: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].pois?.isEmpty ?? true {
                EncounterPOIEdit(editMode: .add)
            } else {
                EncounterPOIList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterPOI_Preview: PreviewProvider {
    static var previews: some View {
        EncounterPOI().environmentObject(ModuleInfo())
    }
}

