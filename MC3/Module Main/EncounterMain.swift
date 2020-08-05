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
    @State private var encounterID: Int?
    @State private var encounterEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterEdit(editMode: editMode),
                tag: -1,
                selection: $encounterEditing
            ) {EmptyView()}

            ModuleSegmentHeader(
                title: "Encounter",
                action: {
                    self.editMode = .add
                    self.encounterEditing = -1
            })
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(0..<moduleInfo.currentModule.content.encounters.count, id: \.self) { (index) in
                        NavigationLink(
                            destination: EncounterExpanded(),
                            tag: index,
                            selection: self.encounterBinding(index)
                        ) {
                            self.getContentCard(index)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
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
            },
            actionEdit: {
                self.moduleInfo.encounterIndex = index
                self.editMode = .edit
                self.encounterEditing = -1
            }
        )
    }
}

struct Encounter_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMain().environmentObject(ModuleInfo())
    }
}
