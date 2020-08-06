//
//  EncounterTreasureList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTreasureList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var treasureID: Int?
    @State private var treasureEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterTreasureEdit(editMode: editMode),
                tag: -1,
                selection: $treasureEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .Treasure,
                        isEditable: true,
                        action: {self.treasureEditing = -1})
                    
                    ScrollView {
                        ZStack {
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(10)
                                    .frame(height: CGFloat((self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].treasure?.count ?? 0) * 134 + 30))
                                    //TODO: Programatically edit height
                            }
                            
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.separator)
                                    .frame(width: UIScreen.main.bounds.width, height: 1)
                                
                                ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].treasure?.count ?? 1), id: \.self) { (index) in
                                    NavigationLink(
                                        destination: EncounterTreasureDetail(),
                                        tag: index,
                                        selection: self.treasureBinding(index)
                                    ) {
                                        self.getContentCard(index)
                                        }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(Color.black)//
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
    
    private func treasureBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.treasureID
        }, set: {
            self.moduleInfo.treasureIndex = index
            self.treasureID = $0
        })
        return binding
    }
    
    private func getContentCard(_ index: Int) -> ContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let baseTreasure = encounter.treasure?[index] {
            var title: String = ""
            var desc: String = ""
            
            switch baseTreasure.treasureType {
            case .weapon:
                if let treasure = baseTreasure as? Weapon {
                    title = treasure.name
                    desc = treasure.desc
                }
            case .magic:
                if let treasure = baseTreasure as? Magic {
                    title = treasure.name
                    desc = treasure.desc
                }
            case .item:
                if let treasure = baseTreasure as? Item {
                    title = treasure.name
                    desc = treasure.desc
                }
            case .coin:
                if let treasure = baseTreasure as? Coin {
                    title = "Coins"
                    if treasure.platinum > 0 {
                        desc += "\(treasure.platinum) platinum coins\n"
                    }
                    if treasure.gold > 0 {
                        desc += "\(treasure.gold) gold coins\n"
                    }
                    if treasure.emerald > 0 {
                        desc += "\(treasure.emerald) emeralds\n"
                    }
                    if treasure.silver > 0 {
                        desc += "\(treasure.silver) silver coins\n"
                    }
                    if treasure.copper > 0 {
                        desc += "\(treasure.copper) copper coins\n"
                    }
                }
            case .armor:
                if let treasure = baseTreasure as? Armor {
                    title = treasure.name
                    desc = treasure.desc
                }
            }
            
            return ContentCard(
                title: title,
                description: desc,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].treasure?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.treasureIndex = index
                    self.editMode = .edit
                    self.treasureEditing = -1
                }
            )
        } else {
            return ContentCard(title: "", description: "", actionDelete: {}, actionEdit: {})
        }
    }
}

struct EncounterTreasureList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterTreasureList().environmentObject(ModuleInfo())
    }
}
