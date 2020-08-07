//
//  EncounterPOIList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterPOIList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var poiID: Int?
    @State private var poiEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterPOIEdit(editMode: editMode),
                tag: -1,
                selection: $poiEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .POI,
                        isEditable: true,
                        action: {self.poiEditing = -1})
                    
                    ScrollView {
                        VStack(spacing: 10) {
//                            Rectangle()
//                                .fill(Color.separator)
//                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].pois?.count ?? 1), id: \.self) { (index) in
                                NavigationLink(
                                    destination: EncounterPOIDetail(),
                                    tag: index,
                                    selection: self.poiBinding(index)
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
    
    private func poiBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.poiID
        }, set: {
            self.moduleInfo.poiIndex = index
            self.poiID = $0
        })
        return binding
    }
    
    private func getOverviewCard(_ index: Int) -> OverviewCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let poi = encounter.pois?[index] {
            return OverviewCard(
                title: poi.name,
                description: poi.desc,
                image: poi.image,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].pois?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.poiIndex = index
                    self.editMode = .edit
                    self.poiEditing = -1
                }
            )
        } else {
            return OverviewCard()
        }
    }
}

struct EncounterPOIList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterPOIList().environmentObject(ModuleInfo())
    }
}
