//
//  EncounterEnvironmentList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterEnvironmentList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var environmentID: Int?
    @State private var environmentEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterEnvironmentEdit(editMode: editMode),
                tag: -1,
                selection: $environmentEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .Environment,
                        isEditable: false,
                        action: {self.environmentEditing = -1})
                    
//                    ScrollView {
                        VStack(spacing: 0) {
//                            Rectangle()
//                                .fill(Color.separator)
//                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].environment?.count ?? 1), id: \.self) { (index) in
                                NavigationLink(
                                    destination: EncounterEnvironmentDetail(),
                                    tag: index,
                                    selection: self.environmentBinding(index)
                                ) {
                                    self.getOverviewCard(index)
                                    }.buttonStyle(PlainButtonStyle())
                                .foregroundColor(Color.black)
                            }
                        }
                    
                    Spacer()
//                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func environmentBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.environmentID
        }, set: {
            self.moduleInfo.environmentIndex = index
            self.environmentID = $0
        })
        return binding
    }
    
    private func getOverviewCard(_ index: Int) -> EnvironmentOverviewCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let environmentModel = encounter.environment?[index] {
            return EnvironmentOverviewCard(
                weather: environmentModel.weather,
                terrain: environmentModel.terrain,
                description: environmentModel.desc,
                image: environmentModel.image,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].environment?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.environmentIndex = index
                    self.editMode = .edit
                    self.environmentEditing = -1
                }
            )
        } else {
            return EnvironmentOverviewCard(weather: "Weather", terrain: "Terrain", description: "Description", image: URL(fileURLWithPath:""))
        }
    }
}

struct EncounterEnvironmentList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterEnvironmentList().environmentObject(ModuleInfo())
    }
}
