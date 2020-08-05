//
//  EncounterTreasureDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTreasureDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var treasureEditing: Int?
    @State var treasure: Treasure = Item(name: "", weight: 0, quantity: 0, cost: "", desc: "")
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterTreasureEdit(editMode: .edit),
                tag: -1,
                selection: $treasureEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    TreasureDetailCard(
                        treasure: treasure,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].treasure?.remove(at: self.moduleInfo.treasureIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.treasureEditing = -1}
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
            if let treasure = encounter.treasure?[self.moduleInfo.treasureIndex] {
                self.treasure = treasure
            }
        })
    }
}

struct EncounterTreasureDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterTreasureDetail(treasure: Magic(name: "Amulet of Health", type: "Wondrous Item", rarity: "Legendary", maxCharge: 1, weight: 1, desc: "Your Constitution score is 19 while you wear this amulet. It has no effect on you if your Constitution is already 19 or higher.")).environmentObject(ModuleInfo())
    }
}
