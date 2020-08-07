//
//  EncounterNotesEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNotesEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    @State var description: String = ""
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .Notes, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 0) {
                            MultiLineField(
                                description: descriptionPlaceholder,
                                inputText: $description
                            )
                                .padding(.vertical, 20)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let noteIndex = self.moduleInfo.noteIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].notes = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].notes?.append(
                                            Notes(desc: self.description)
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].notes?[noteIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].notes?[noteIndex].desc = self.description
                                        }
                                    }
                                    
                                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                                    if !self.initial {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                })
                            }
                            .padding(.horizontal, 30)
                            .padding(.bottom, 20)
                        }
                    }
                    .frame(height: 349)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let noteIndex = self.moduleInfo.noteIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].notes?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let note = self.moduleInfo.currentModule.content.encounters[encounterIndex].notes?[noteIndex] {
                    self.description = note.desc
                    
                    if note.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterNotesEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterNotesEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
