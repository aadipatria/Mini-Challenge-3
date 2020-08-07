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
    
    @State private var treasureSegmentIndex = 0
    @State private var treasureSegment = ["Armor", "Coins", "Item", "Magic", "Weapon"]
    
    @State var initial: Bool = false
    var editMode: EditMode
    
    @State var treasure: Treasure = Item(name: "Treasure", weight: "", quantity: "", cost: "", desc: "")
    
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
                
                switch self.treasure.treasureType {
                case .armor:
                    self.treasureSegmentIndex = 0
                case .coin:
                    self.treasureSegmentIndex = 1
                case .item:
                    self.treasureSegmentIndex = 2
                case .magic:
                    self.treasureSegmentIndex = 3
                case .weapon:
                    self.treasureSegmentIndex = 4
                }
            }
        })
    }
    
    func getMainContent(index: Int) -> AnyView {
        let actionNext = {self.presentationMode.wrappedValue.dismiss()}
        
        switch index {
        case 0:
            return AnyView(EncounterTreasureEditArmor(
                treasure: $treasure,
                actionNext: actionNext,
                initial: self.initial,
                editMode: self.editMode))
        case 1:
            return AnyView(EncounterTreasureEditCoins(
                treasure: $treasure,
                actionNext: actionNext,
                initial: self.initial,
                editMode: self.editMode))
        case 2:
            return AnyView(EncounterTreasureEditItem(
                treasure: $treasure,
                actionNext: actionNext,
                initial: self.initial,
                editMode: self.editMode))
        case 3:
            return AnyView(EncounterTreasureEditMagic(
                treasure: $treasure,
                actionNext: actionNext,
                initial: self.initial,
                editMode: self.editMode))
        case 4:
            return AnyView(EncounterTreasureEditWeapon(
                treasure: $treasure,
                actionNext: actionNext,
                initial: self.initial,
                editMode: self.editMode))
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
