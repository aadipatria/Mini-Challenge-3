//
//  EncounterRATDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterRATDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var ratEditing: Int?
    @State private var title: String = ""
    @State private var description: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterRATEdit(editMode: .edit),
                tag: -1,
                selection: $ratEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: title,
                        description: description,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].readAloudText?.remove(at: self.moduleInfo.ratIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
//                            self.presentationMode.wrappedValue.dismiss()
                        },
                        actionEdit: {self.ratEditing = -1}
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
            if let rat = encounter.readAloudText?[self.moduleInfo.ratIndex] {
                self.title = rat.name
                self.description = rat.desc
            }
        })
    }
}

struct EncounterRATDetail_Previews: PreviewProvider {
    static var previews: some View {
        //EncounterRATDetail(title: "No Rules", description: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.").environmentObject(ModuleInfo())
        EncounterRATDetail().environmentObject(ModuleInfo())
    }
}
