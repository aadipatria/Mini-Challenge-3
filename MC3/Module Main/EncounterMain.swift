//
//  EncounterMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMain: View {
    @EnvironmentObject var moduleInfo : ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State private var encounterName: String = ""
    @State private var encounterLocation: String = ""
    
    @State private var encounterID: Int?
    @State private var encounterEditing: Bool = false
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {            
            ModuleSegmentHeader(
                title: "Encounter",
                action: {
                    self.editMode = .add
                    self.encounterName = ""
                    self.encounterLocation = ""
                    self.encounterEditing = true},
                isEditable: !self.encounterEditing)
            
            if encounterEditing {
                EncounterEdit(
                    encounterName: $encounterName,
                    encounterLocation: $encounterLocation,
                    editMode: .add,
                    actionCancel: {self.encounterEditing = false},
                    actionNext: {
                        let index = self.moduleInfo.encounterIndex

                        if self.editMode == .add {
                            self.moduleInfo.currentModule.content.encounters.append(
                                Encounter(name: self.encounterName, location: self.encounterLocation))
                        } else if self.editMode == .edit {
                            self.moduleInfo.currentModule.content.encounters[index].name = self.encounterName
                            self.moduleInfo.currentModule.content.encounters[index].location = self.encounterLocation
                        }

                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        self.encounterEditing = false
                })
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .frame(height: CGFloat((self.moduleInfo.currentModule.content.encounters.count) * 134 + 30))
                        
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.separator)
                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<moduleInfo.currentModule.content.encounters.count, id: \.self) { (index) in
                                NavigationLink(
                                    destination: EncounterExpanded(),
                                    tag: index,
                                    selection: self.encounterBinding(index)
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
            if self.moduleInfo.currentModule.content.encounters.count < 1 {
                self.encounterEditing = true
            }
        })
    }
    
    func encounterBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.encounterID
        }, set: {
            self.moduleInfo.encounterIndex = index
            self.encounterID = $0
        })
        return binding
    }
    
    func getContentCard(_ index: Int) -> ContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[index]
        return ContentCard(
            title: encounter.name,
            description: encounter.location,
            actionDelete: {
                self.moduleInfo.currentModule.content.encounters.remove(at: index)
                self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                
                if self.moduleInfo.currentModule.content.encounters.count < 1 {
                    self.encounterEditing = true
                }
            },
            actionEdit: {
                self.moduleInfo.encounterIndex = index
                self.encounterName = encounter.name
                self.encounterLocation = encounter.location
                self.editMode = .edit
                self.encounterEditing = true
            }
        )
    }
}

struct Encounter_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMain().environmentObject(ModuleInfo())
    }
}
