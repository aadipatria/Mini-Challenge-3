//
//  EncounterExpanded.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 28/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterExpanded: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                EncounterSectionList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}


struct EncounterSectionList: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @State var encounter: Encounter = Encounter(name: "", location: "")
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(encounter.name)
                    .padding(.top, 20)
                    .padding(.leading, 30)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                Spacer()
            }
            .padding(.bottom, 30)
            
            Rectangle()
                .fill(Color.separator)
                .frame(width: UIScreen.main.bounds.width, height: 2)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(EncounterSection.allCases, id: \.self) {(sections) in
                        self.getLink(section: sections)
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .frame(minWidth: UIScreen.main.bounds.width, idealHeight: UIScreen.main.bounds.height)
        .padding(.top, 32)
            
        .onAppear(perform: {
            self.encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        })
    }

    func getLink(section: EncounterSection) -> some View {
        let index = self.moduleInfo.encounterIndex
        let encounter = self.moduleInfo.currentModule.content.encounters[index]
        
        var destination: AnyView
        var isEmpty: Bool
        
        switch section {
        case .Environment:
            destination = AnyView(EncounterEnvironment())
            isEmpty = (encounter.environment == nil)
        case .Traps:
            destination = AnyView(EncounterTraps())
            isEmpty = (encounter.traps == nil)
        case .Maps:
            destination = AnyView(EncounterMaps())
            isEmpty = (encounter.maps == nil)
        case .POI:
            destination = AnyView(EncounterPOI())
            isEmpty = (encounter.pois == nil)
        case .NPC:
            destination = AnyView(EncounterNPC())
            isEmpty = (encounter.npcs == nil)
        case .Monsters:
            destination = AnyView(EncounterMonsters())
            isEmpty = (encounter.monsters == nil)
        case .ReadAloudText:
            destination = AnyView(EncounterRAT())
            isEmpty = (encounter.readAloudText == nil)
        case .Treasure:
            destination = AnyView(EncounterTreasure())
            isEmpty = (encounter.treasure == nil)
        case .Notes:
            destination = AnyView(EncounterNotes())
            isEmpty = (encounter.notes == nil)
        }
        
        return NavigationLink(destination: destination) {
            EncounterSectionCard(isEmpty: isEmpty, section: section)
        }.buttonStyle(PlainButtonStyle())
    }
}

struct EncounterExpanded_Preview: PreviewProvider {
    static var previews: some View {
        //EncounterExpanded(encounter: ModulesStub.modulContent.last?.encounters[0] ?? Encounter(name: "Title", location: "Desc")).environmentObject(ModuleInfo())
        EncounterExpanded().environmentObject(ModuleInfo())
        //EncounterNotification()
    }
}

//circle system blue 24
//! rounded bold 17
