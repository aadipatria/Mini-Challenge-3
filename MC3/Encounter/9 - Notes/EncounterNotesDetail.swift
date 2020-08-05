//
//  EncounterNotesDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNotesDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var notesEditing: Int?
    @State private var description: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterNotesEdit(editMode: .edit),
                tag: -1,
                selection: $notesEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: "Notes",
                        description: description,
                        actionDelete: {
                            //self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].notes?.remove(at: self.moduleInfo.noteIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.notesEditing = -1}
                    )
                        .padding(.top, 32)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
            if let note = encounter.notes?[self.moduleInfo.noteIndex] {
                self.description = note.desc
            }
        })
    }
}

struct EncounterNotesDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterNotesDetail().environmentObject(ModuleInfo())
    }
}
