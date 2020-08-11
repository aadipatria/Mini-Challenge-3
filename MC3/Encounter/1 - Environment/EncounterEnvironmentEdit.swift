//
//  EncounterEnvironmentEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterEnvironmentEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    
    @State var environmentWeather: String = ""
    @State var environmentTerrain: String = ""
    @State var environmentDescription: String = ""
    @State var environmentImage: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "SampleRectangle", ofType: "png")!)
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .Environment, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Weather",
                                image: "TextfieldEnvironmentWeather",
                                inputText: $environmentWeather
                            )
                                .padding(.top, 20)

//                            UploadImageButton(image: $environmentImage)
                            
                            SingleLineField(
                                description: "Terrain",
                                image: "TextfieldEnvironmentTerrain",
                                inputText: $environmentTerrain
                            )
                            
                            MultiLineField(
                                description: "Description",
                                inputText: $environmentDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let environmentIndex = self.moduleInfo.environmentIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].environment = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?.append(
                                            EnvironmentModel(
                                                weather: self.environmentWeather,
                                                terrain: self.environmentTerrain,
                                                image: self.environmentImage,
                                                desc: self.environmentDescription
                                            )
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex].weather = self.environmentWeather
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex].image = self.environmentImage
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex].terrain = self.environmentTerrain
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex].desc = self.environmentDescription
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
                    .frame(height: 341)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let environmentIndex = self.moduleInfo.environmentIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let environmentModel = self.moduleInfo.currentModule.content.encounters[encounterIndex].environment?[environmentIndex] {
                    self.environmentWeather = environmentModel.weather
                    self.environmentImage = environmentModel.image
                    self.environmentTerrain = environmentModel.terrain
                    self.environmentDescription = environmentModel.desc
                    
                    if environmentModel.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterEnvironmentEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterEnvironmentEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
