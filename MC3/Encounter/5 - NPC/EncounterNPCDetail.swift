//
//  EncounterNPCDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNPCDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var npcEditing: Int?
    @State private var name: String = ""
    @State private var race: String = ""
    @State private var description: String = ""
    @State private var image: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "RealBrad", ofType: "png")!)
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterNPCEdit(editMode: .edit),
                tag: -1,
                selection: $npcEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: name,
                        subtitle: race,
                        description: description,
                        image: image,
                        isClipped: true,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].npcs?.remove(at: self.moduleInfo.npcIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.npcEditing = -1}
                    )
                        .padding(.top, 32)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
            if let npc = encounter.npcs?[self.moduleInfo.npcIndex] {
                self.name = npc.name
//                self.race = npc.race
                self.description = npc.desc
                self.image = npc.image
                
                if npc.race != "" {
                    self.race = "(\(npc.race))"
                }
            }
        })
    }
}

struct EncounterNPCDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterNPCDetail().environmentObject(ModuleInfo())
    }
}
