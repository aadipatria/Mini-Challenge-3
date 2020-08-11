//
//  EncounterNPCEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNPCEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    
    @State var npcName: String = ""
    @State var npcRace: String = ""
    @State var npcDescription: String = ""
    @State var npcImage: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "SampleOval", ofType: "png")!)
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .NPC, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Name",
                                image: "TextfieldNPCName",
                                inputText: $npcName
                            )
                                .padding(.top, 20)

                            SingleLineField(
                                description: "Race",
                                image: "TextfieldNPCRace",
                                inputText: $npcRace
                            )
                            
//                            UploadImageButton(image: $npcImage)
                            
                            MultiLineField(
                                description: descriptionPlaceholder,
                                inputText: $npcDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let npcIndex = self.moduleInfo.npcIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?.append(
                                            NPC(
                                                name: self.npcName,
                                                race: self.npcRace,
                                                image: self.npcImage,
                                                desc: self.npcDescription)
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex].name = self.npcName
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex].race = self.npcRace
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex].desc = self.npcDescription
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex].image = self.npcImage
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
            let npcIndex = self.moduleInfo.npcIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let npc = self.moduleInfo.currentModule.content.encounters[encounterIndex].npcs?[npcIndex] {
                    self.npcName = npc.name
                    self.npcRace = npc.race
                    self.npcDescription = npc.desc
                    self.npcImage = npc.image
                    
                    if npc.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterNPCEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterNPCEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
