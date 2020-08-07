//
//  EncounterMapsList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMapsList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var mapsID: Int?
    @State private var mapsEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterMapsEdit(editMode: editMode),
                tag: -1,
                selection: $mapsEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .Maps,
                        isEditable: true,
                        action: {self.mapsEditing = -1})
                    
                    ScrollView {
                        VStack(spacing: 10) {
//                            Rectangle()
//                                .fill(Color.separator)
//                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].maps?.count ?? 1), id: \.self) { (index) in
                                NavigationLink(
                                    destination: EncounterMapsDetail(),
                                    tag: index,
                                    selection: self.mapsBinding(index)
                                ) {
                                    self.getOverviewCard(index)
                                    }.buttonStyle(PlainButtonStyle())
                                .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func mapsBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.mapsID
        }, set: {
            self.moduleInfo.mapsIndex = index
            self.mapsID = $0
        })
        return binding
    }
    
    private func getOverviewCard(_ index: Int) -> OverviewCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let maps = encounter.maps?[index] {
            return OverviewCard(
                title: maps.name,
                description: maps.desc,
                image: maps.image,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].maps?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.mapsIndex = index
                    self.editMode = .edit
                    self.mapsEditing = -1
                }
            )
        } else {
            return OverviewCard(
//                title: "", description: "", actionDelete: {}, actionEdit: {}
            )
        }
    }
}

struct EncounterMapsList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMapsList().environmentObject(ModuleInfo())
    }
}
