//
//  EncounterNotes.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNotes: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack {
            if self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].notes?.isEmpty ?? true {
                EncounterNotesEdit(editMode: .add)
            } else {
                EncounterNotesDetail()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterNotes_Preview: PreviewProvider {
    static var previews: some View {
        EncounterNotes().environmentObject(ModuleInfo())
    }
}

