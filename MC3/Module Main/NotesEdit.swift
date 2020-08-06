//
//  NotesEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct NotesEdit: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var notesName: String
    @Binding var notesDescription: String
    @State var editMode: EditMode
    @State var descriptionPlaceholder: String = "Empty Note"
    
    var actionCancel: () -> ()
    var actionNext: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 316)
                    .cornerRadius(10)
                    .onTapGesture {ModuleInfo.endEditing()}
                
                VStack(spacing: 20) {
                    SingleLineField(
                        description: "Title",
                        image: "TextfieldMainNotes",
                        inputText: $notesName)
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        height: 158,
                        inputText: $notesDescription)
                    
                    HStack(spacing: 30) {
                        if self.moduleInfo.currentModule.content.notes.count > 0 {
                            CancelButton(action: actionCancel)
                        }
                        NextButton(action: actionNext)
                    }.padding(.horizontal, 30)
                }
            }.onAppear(perform: {
                if self.editMode == .edit {
                    let index = self.moduleInfo.mainNoteIndex
                    let note = self.moduleInfo.currentModule.content.notes[index]
                    self.notesName = note.name
                    self.notesDescription = note.desc
                    
                    if note.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            })
        }
    }
}
