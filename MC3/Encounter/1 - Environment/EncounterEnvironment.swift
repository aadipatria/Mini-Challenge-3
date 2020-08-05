//
//  EncounterEnvironment.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterEnvironment: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].environment?.isEmpty ?? true {
                EncounterEnvironmentEdit(editMode: .add)
            } else {
                EncounterEnvironmentList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterEnvironment_Preview: PreviewProvider {
    static var previews: some View {
        EncounterEnvironment().environmentObject(ModuleInfo())
    }
}
