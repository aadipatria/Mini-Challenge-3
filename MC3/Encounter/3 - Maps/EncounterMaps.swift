//
//  EncounterMaps.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMaps: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].maps?.isEmpty ?? true {
                EncounterMapsEdit(editMode: .add)
            } else {
                EncounterMapsList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterMaps_Preview: PreviewProvider {
    static var previews: some View {
        EncounterMaps().environmentObject(ModuleInfo())
    }
}

