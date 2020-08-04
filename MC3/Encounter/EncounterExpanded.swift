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
            ModuleHeader(
                module: moduleInfo.currentModule.name,
                author: moduleInfo.currentModule.author.name,
                image: moduleInfo.currentModule.author.image,
                action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
//                EncounterSectionList(encounter: moduleInfo.encounter)
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
//    var readAloudText : [ReadAloudText]?
    
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
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.environment ?? []).isEmpty,
                            section: .Environment)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.traps ?? []).isEmpty,
                            section: .Traps)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.maps ?? []).isEmpty,
                            section: .Maps)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.pois ?? []).isEmpty,
                            section: .POI)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.npcs ?? []).isEmpty,
                            section: .NPC)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.monsters ?? []).isEmpty,
                            section: .Monsters)
                    }.buttonStyle(PlainButtonStyle())
                    
                    getLink(
                        destination: AnyView(EncounterRATList()),
                        section: .ReadAloudText)
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.treasure ?? []).isEmpty,
                            section: .Treasure)
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(
                        destination: ModuleMain()
                    ) {
                        EncounterSectionCard(
                            isEmpty: (encounter.notes ?? []).isEmpty,
                            section: .Notes)
                    }.buttonStyle(PlainButtonStyle())
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
    
    func getLink(destination: AnyView, section: EncounterSection) -> some View {
        let index = self.moduleInfo.encounterIndex
        let encounter = self.moduleInfo.currentModule.content.encounters[index]
        var isEmpty: Bool
        
        switch section {
        case .Environment:
            isEmpty = (encounter.environment == nil)
        case .Traps:
            isEmpty = (encounter.traps == nil)
        case .Maps:
            isEmpty = (encounter.maps == nil)
        case .POI:
            isEmpty = (encounter.pois == nil)
        case .NPC:
            isEmpty = (encounter.npcs == nil)
        case .Monsters:
            isEmpty = (encounter.monsters == nil)
        case .ReadAloudText:
            isEmpty = (encounter.readAloudText == nil)
        case .Treasure:
            isEmpty = (encounter.treasure == nil)
        case .Notes:
            isEmpty = (encounter.notes == nil)
        }
        
        //let navLink =
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
