//
//  EncounterPOIEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterPOIEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var initial: Bool = false
    @State var descriptionPlaceholder: String = "Description"
    
    @State var poiName: String = ""
    @State var poiDescription: String = ""
    @State var poiImage: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "SampleRectangle", ofType: "png")!)
    var editMode: EditMode
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(alignment: .leading, spacing: 0) {
                    EncounterHeader(section: .POI, isEditable: false)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .onTapGesture {ModuleInfo.endEditing()}
                        
                        VStack(spacing: 10) {
                            SingleLineField(
                                description: "Name",
                                image: "TextfieldMapsPOI",
                                inputText: $poiName
                            )
                                .padding(.top, 20)

//                            UploadImageButton(image: $poiImage)
                            
                            MultiLineField(
                                description: descriptionPlaceholder,
                                inputText: $poiDescription
                            )
                                .padding(.bottom, 10)

                            HStack(spacing: 30) {
                                CancelButton(action: {
                                    self.presentationMode.wrappedValue.dismiss()
                                })
                                
                                NextButton(action: {
                                    let encounterIndex = self.moduleInfo.encounterIndex
                                    let poiIndex = self.moduleInfo.poiIndex
                                    
                                    if self.editMode == .add {
                                        if self.initial {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].pois = []
                                        }
                                        
                                        self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?.append(
                                            POI(
                                                name: self.poiName,
                                                desc: self.poiDescription,
                                                image: self.poiImage)
                                        )
                                    } else if self.editMode == .edit {
                                        if (self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?[poiIndex]) != nil {
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?[poiIndex].name = self.poiName
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?[poiIndex].desc = self.poiDescription
                                            self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?[poiIndex].image = self.poiImage
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
            let poiIndex = self.moduleInfo.poiIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let poi = self.moduleInfo.currentModule.content.encounters[encounterIndex].pois?[poiIndex] {
                    self.poiName = poi.name
                    self.poiDescription = poi.desc
                    self.poiImage = poi.image
                    
                    if poi.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            }
        })
    }
}

struct EncounterPOIEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterPOIEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
