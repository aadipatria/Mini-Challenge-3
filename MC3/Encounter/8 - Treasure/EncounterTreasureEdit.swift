//
//  EncounterTreasureEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTreasureEdit: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State var treasureSegmentIndex = 0
    @State var treasureSegment = ["Armor", "Coins", "Item", "Magic", "Weapon"]
    
    @State var initial: Bool = false
    var editMode: EditMode
    
    @State private var treasure: Treasure = Item(name: "", weight: 0, quantity: 0, cost: "", desc: "")
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    Picker(selection: $treasureSegmentIndex, label: Rectangle()) {
                        ForEach(0..<treasureSegment.count) { index in
                            Text(self.treasureSegment[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.all, 30)
                    
                    HStack {
                        if treasureSegmentIndex != 3 {
                            Text(treasureSegment[treasureSegmentIndex])
                                .font(.system(size: 21, weight: .medium, design: .rounded))
                        } else {
                            Text("Magic Item")
                            .font(.system(size: 21, weight: .medium, design: .rounded))
                        }
                        Spacer()
                    }
                    .padding(.bottom, 30)
                    .padding(.leading, 40)
                    
                    getMainContent(index: treasureSegmentIndex)
                    
                    Spacer()
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let encounterIndex = self.moduleInfo.encounterIndex
            let treasureIndex = self.moduleInfo.treasureIndex
            
            if self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.count ?? 0 == 0 {
                    self.initial = true
            }
            
            if self.editMode == .edit {
                if let treasure = self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex] {
                    self.treasure = treasure
                }
            }
        })
    }
    
    func getMainContent(index: Int) -> AnyView {
        let encounterIndex = self.moduleInfo.encounterIndex
        let treasureIndex = self.moduleInfo.treasureIndex
        
        var placeholder = "Description"
        
        let actionNext = {
            if self.editMode == .add {
                if self.initial {
                    self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure = []
                }

                self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.append(self.treasure)

            } else if self.editMode == .edit {
                if (self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?[treasureIndex]) != nil {
                        self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.remove(at: treasureIndex)
                    self.moduleInfo.currentModule.content.encounters[encounterIndex].treasure?.insert(self.treasure, at: treasureIndex)
                }
            }

            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
            if !self.initial {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        
        switch index {
        case 0:
            if editMode == .edit && treasure.treasureType == .armor {placeholder = ""}
            return AnyView(EncounterTreasureEditArmor(
                treasure: $treasure,
                actionNext: actionNext,
                descriptionPlaceholder: placeholder))
        case 1:
            return AnyView(EncounterTreasureEditCoins(
                treasure: $treasure,
                actionNext: actionNext))
        case 2:
            if editMode == .edit && treasure.treasureType == .item {placeholder = ""}
            return AnyView(EncounterTreasureEditItem(
                treasure: $treasure,
                actionNext: actionNext,
                descriptionPlaceholder: placeholder))
        case 3:
            if editMode == .edit && treasure.treasureType == .magic {placeholder = ""}
            return AnyView(EncounterTreasureEditMagic(
                treasure: $treasure,
                actionNext: actionNext,
                descriptionPlaceholder: placeholder))
        case 4:
            if editMode == .edit && treasure.treasureType == .weapon {placeholder = ""}
            return AnyView(EncounterTreasureEditWeapon(
                treasure: $treasure,
                actionNext: actionNext,
                descriptionPlaceholder: placeholder))
        default:
            return AnyView(EmptyView())
        }
    }
}

struct EncounterTreasureEdit_Preview: PreviewProvider {
    static var previews: some View {
        EncounterTreasureEdit(editMode: .add).environmentObject(ModuleInfo())
    }
}
