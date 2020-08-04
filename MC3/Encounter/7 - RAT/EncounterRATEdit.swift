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
    
    @State var ratName: String = ""
    @State var ratDescription: String = ""
    var editMode: EditMode
    var RAT: ReadAloudText?
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(module: moduleInfo.currentModule.name,
                         author: moduleInfo.currentModule.author.name,
                         image: moduleInfo.currentModule.author.image,
                         action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .ReadAloudText, isEditable: false, action: {})
                    
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

                            MultiLineField(description: "Description")
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let ratIndex = self.moduleInfo.ratIndex
                                    
                                    if self.editMode == .add {
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
                                    self.presentationMode.wrappedValue.dismiss()
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
            if self.editMode == .edit {
                let encounterIndex = self.moduleInfo.encounterIndex
                let ratIndex = self.moduleInfo.ratIndex
                if let rat = self.moduleInfo.currentModule.content.encounters[encounterIndex].readAloudText?[ratIndex] {
                    self.ratName = rat.name
                    self.ratDescription = rat.desc
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
