//
//  EncounterRATEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterRATEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    @State var ratName: String = ""
    @State var ratDescription: String = ""
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .ReadAloudText, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Name",
                                image: "TextfieldRAT",
                                inputText: $ratName
                            )
                                .padding(.top, 20)

                            MultiLineField(
                                description: descriptionPlaceholder,
                                inputText: $ratDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let ratIndex = self.moduleInfo.ratIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?.append(
                                            ReadAloudText(
                                                name: self.ratName,
                                                desc: self.ratDescription)
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?[ratIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?[ratIndex].name = self.ratName
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?[ratIndex].desc = self.ratDescription
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
                    .frame(height: 252)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let ratIndex = self.moduleInfo.ratIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let rat = self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?[ratIndex] {
                    self.ratName = rat.name
                    self.ratDescription = rat.desc
                    
                    if rat.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterRATEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterRATEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
