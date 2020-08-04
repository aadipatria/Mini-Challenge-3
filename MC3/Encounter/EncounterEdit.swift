//
//  EncounterEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 03/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var encounterName: String = ""
    @State var encounterLocation: String = ""
    @State var editMode: EditMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(height: 202)
                .cornerRadius(10)
                .onTapGesture {ModuleInfo.endEditing()}
            
            VStack(spacing: 20) {
                SingleLineField(
                    description: "Encounter Name",
                    image: "TextfieldEncounterName",
                    inputText: $encounterName)
                
                SingleLineField(
                description: "Location",
                image: "TextfieldEncounterLocation",
                inputText: $encounterLocation)
                
                HStack(spacing: 30) {
                    CancelButton(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    })
                    NextButton(action: {
                        let index = self.moduleInfo.encounterIndex
                        
                        if self.editMode == .add {
                            self.moduleInfo.currentModule.content.encounters.append(
                                Encounter(name: self.encounterName, location: self.encounterLocation))
                        } else if self.editMode == .edit {
                            self.moduleInfo.currentModule.content.encounters[index].name = self.encounterName
                            self.moduleInfo.currentModule.content.encounters[index].location = self.encounterLocation
                        }
                        
                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }.padding(.horizontal, 30)
            }
        }.onAppear(perform: {
            if self.editMode == .edit {
                let index = self.moduleInfo.encounterIndex
                let encounter = self.moduleInfo.currentModule.content.encounters[index]
                self.encounterName = encounter.name
                self.encounterLocation = encounter.location
            }
        })
    }
}

struct EncounterEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
