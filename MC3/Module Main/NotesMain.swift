//
//  NotesMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct NotesMain: View {
    @EnvironmentObject var moduleInfo : ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State private var notesName: String = ""
    @State private var notesDescription: String = ""
    
    @State private var notesID: Int?
    @State private var notesEditing: Bool = false
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleSegmentHeader(
                title: "Notes",
                action: {
                    self.editMode = .add
                    self.notesName = ""
                    self.notesDescription = ""
                    self.notesEditing = true},
                    isEditable: !self.notesEditing)
            
            if notesEditing {
                NotesEdit(
                    notesName: $notesName,
                    notesDescription: $notesDescription,
                    editMode: .add,
                    actionCancel: {
                        self.editMode = .add
                        self.notesEditing = false
                    },
                    actionNext: {
                        let index = self.moduleInfo.mainNoteIndex

                        if self.editMode == .add {
                            self.moduleInfo.currentModule.content.notes.append(
                                MainNotes(name: self.notesName,
                                          desc: self.notesDescription))
                        } else if self.editMode == .edit {
                            self.moduleInfo.currentModule.content.notes[index].name = self.notesName
                            self.moduleInfo.currentModule.content.notes[index].desc = self.notesDescription
                        }

                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        self.notesEditing = false
                })
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .frame(height: CGFloat((self.moduleInfo.currentModule.content.notes.count) * 134 + 30))
                        
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.separator)
                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<moduleInfo.currentModule.content.notes.count, id: \.self) { (index) in
                                NavigationLink(
                                    destination: NotesDetail(
                                        notesEditing: self.$notesEditing),
                                    tag: index,
                                    selection: self.noteBinding(index)
                                ) {
                                    self.getContentCard(index)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }.padding(.vertical, 20)
                    }
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            if self.moduleInfo.currentModule.content.notes.count < 1 {
                self.notesEditing = true
            }
        })
    }
    
    func noteBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.notesID
        }, set: {
            self.moduleInfo.mainNoteIndex = index
            self.notesID = $0
        })
        return binding
    }
    
    func getContentCard(_ index: Int) -> ContentCard {
        let note = self.moduleInfo.currentModule.content.notes[index]
        return ContentCard(
            title: note.name,
            description: note.desc,
            actionDelete: {
                self.moduleInfo.currentModule.content.notes.remove(at: index)
                self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                
                if self.moduleInfo.currentModule.content.notes.count < 1 {
                    self.notesEditing = true
                }
            },
            actionEdit: {
                self.moduleInfo.mainNoteIndex = index
                self.notesName = note.name
                self.notesDescription = note.desc
                self.editMode = .edit
                self.notesEditing = true
            }
        )
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        NotesMain()
    }
}
