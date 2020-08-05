//
//  EncounterTrapsEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTrapsEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var trapName: String = ""
    @State var trapThreat: String = ""
    @State var trapTrigger: String = ""
    @State var trapEffect: String = ""
    @State var trapLevel: String = ""
    @State var trapCountermeasure: String = ""
    @State var trapDescription: String = ""
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .Traps, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Name",
                                image: "TextfieldTrapsName",
                                inputText: $trapName
                            )
                                .padding(.top, 20)

                            SingleLineField(
                                description: "Level (5-10",
                                image: "TextfieldTrapsLevel",
                                inputText: $trapLevel
                            )
                            
                            SingleLineField(
                                description: "Threat (Deadly)",
                                image: "TextfieldTrapsThreat",
                                inputText: $trapThreat
                            )
                            
                            SingleLineField(
                                description: "Trigger (Stepping on false floor)",
                                image: "TextfieldTrapsTrigger",
                                inputText: $trapTrigger
                            )
                            
                            SingleLineField(
                                description: "Effect",
                                image: "TextfieldTrapsEffect",
                                inputText: $trapEffect
                            )
                            
                            SingleLineField(
                                description: "Countermeasure",
                                image: "TextfieldTrapsCountermeasure",
                                inputText: $trapCountermeasure
                            )
                            
                            MultiLineField(
                                description: "Description",
                                inputText: $trapDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let trapIndex = self.moduleInfo.trapIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?.append(
                                            Trap(
                                                name: self.trapName,
                                                desc: self.trapDescription,
                                                level: self.trapLevel,
                                                threat: self.trapThreat,
                                                trigger: self.trapTrigger,
                                                effect: self.trapEffect,
                                                counterMeasure: self.trapCountermeasure
                                                )
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].name = self.trapName
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].desc = self.trapDescription
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].level = self.trapLevel
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].threat = self.trapThreat
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].trigger = self.trapTrigger
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].effect = self.trapEffect
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex].counterMeasure = self.trapCountermeasure
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
                    .frame(height: 522)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let trapIndex = self.moduleInfo.trapIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let trap = self.moduleInfo.currentModule.content.encounters[encounterIndex].traps?[trapIndex] {
                    self.trapName = trap.name
                    self.trapThreat = trap.threat
                    self.trapTrigger = trap.trigger
                    self.trapEffect = trap.effect
                    self.trapLevel = trap.level
                    self.trapCountermeasure = trap.counterMeasure
                    self.trapDescription = trap.desc
                    
                }
            }
        })
    }
}

struct EncounterTrapsEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterTrapsEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
