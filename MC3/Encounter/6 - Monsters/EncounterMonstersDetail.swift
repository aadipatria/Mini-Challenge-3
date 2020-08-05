//
//  EncounterMonstersDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMonstersDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var monstersEditing: Int?
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var image: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterMonstersEdit(editMode: .edit),
                tag: -1,
                selection: $monstersEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: name,
                        description: description,
                        image: image,
                        isClipped: true,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].monsters?.remove(at: self.moduleInfo.monsterIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.monstersEditing = -1}
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
            if let monster = encounter.monsters?[self.moduleInfo.monsterIndex] {
                self.name = monster.name
                self.description = monster.desc
                self.image = monster.image
            }
        })
    }
}

struct EncounterMonstersDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMonstersDetail().environmentObject(ModuleInfo())
    }
}
