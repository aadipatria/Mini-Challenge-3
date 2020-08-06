//
//  NotesDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct NotesDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var notesEditing: Bool
    @State private var noteTitle: String = ""
    @State private var noteDescription: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: noteTitle,
                        description: noteDescription,
                        actionDelete: {
                            self.moduleInfo.currentModule.content.notes.remove(at:self.moduleInfo.mainNoteIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        actionEdit: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.notesEditing = true
                        }
                    )
                    .padding(.top, 32)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let note = self.moduleInfo.currentModule.content.notes[self.moduleInfo.mainNoteIndex]
            self.noteTitle = note.name
            self.noteDescription = note.desc
        })
    }
}

//struct NotesDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesDetail().environmentObject(ModuleInfo())
//    }
//}
