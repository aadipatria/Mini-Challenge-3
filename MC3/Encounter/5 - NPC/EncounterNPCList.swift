//
//  EncounterNPCList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterNPCList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var npcID: Int?
    @State private var npcEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterNPCEdit(editMode: editMode),
                tag: -1,
                selection: $npcEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .NPC,
                        isEditable: true,
                        action: {self.npcEditing = -1})
                    
                    ScrollView {
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .frame(height: CGFloat((self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].npcs?.count ?? 0) * 134 + 30))
                            
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.separator)
                                    .frame(width: UIScreen.main.bounds.width, height: 1)
                                
                                ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].npcs?.count ?? 1), id: \.self) { (index) in
                                    NavigationLink(
                                        destination: EncounterNPCDetail(),
                                        tag: index,
                                        selection: self.npcBinding(index)
                                    ) {
                                        self.getContentCard(index)
                                        }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(Color.black)
                                }
                            }
                            .padding(.vertical, 20)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func npcBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.npcID
        }, set: {
            self.moduleInfo.npcIndex = index
            self.npcID = $0
        })
        return binding
    }
    
    private func getContentCard(_ index: Int) -> PictureContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let npc = encounter.npcs?[index] {
            var race = npc.race
            if race != "" {
                race = "(\(npc.race))"
            }
            
            return PictureContentCard(
                title: npc.name,
                subtitle: race,
                description: npc.desc,
                image: npc.image,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].npcs?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.npcIndex = index
                    self.editMode = .edit
                    self.npcEditing = -1
                }
            )
        } else {
            return PictureContentCard(title: "Name", subtitle: "", description: "Description", image: UIImage(named: "RealBrad")!, actionDelete: {}, actionEdit: {})
        }
    }
}

struct EncounterNPCList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterNPCList().environmentObject(ModuleInfo())
    }
}
