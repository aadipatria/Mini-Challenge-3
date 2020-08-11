//
//  EncounterMapsEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMapsEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    
    @State var mapsName: String = ""
    @State var mapsDescription: String = ""
    @State var mapsImage: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "SampleRectangle", ofType: "png")!)
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .Maps, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Name",
                                image: "TextfieldMapsPOI",
                                inputText: $mapsName
                            )
                                .padding(.top, 20)

//                            UploadImageButton(image: $mapsImage)
                            
                            MultiLineField(
                                description: descriptionPlaceholder,
                                inputText: $mapsDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let mapsIndex = self.moduleInfo.mapsIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].maps = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?.append(
                                            Maps(
                                                name: self.mapsName,
                                                desc: self.mapsDescription,
                                                image: self.mapsImage)
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?[mapsIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?[mapsIndex].name = self.mapsName
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?[mapsIndex].desc = self.mapsDescription
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?[mapsIndex].image = self.mapsImage
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
                    .frame(height: 295)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let mapsIndex = self.moduleInfo.mapsIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let maps = self.moduleInfo.currentModule.content.encounters[encounterIndex].maps?[mapsIndex] {
                    self.mapsName = maps.name
                    self.mapsDescription = maps.desc
                    self.mapsImage = maps.image
                    
                    if maps.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterMapsEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterMapsEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
