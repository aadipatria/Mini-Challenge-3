//
//  EncounterPOIDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterPOIDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var poiEditing: Int?
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var image: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterPOIEdit(editMode: .edit),
                tag: -1,
                selection: $poiEditing
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
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].pois?.remove(at: self.moduleInfo.poiIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.poiEditing = -1}
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
            if let poi = encounter.pois?[self.moduleInfo.poiIndex] {
                self.title = poi.name
                self.description = poi.desc
                self.image = poi.image
            }
        })
    }
}

struct EncounterPOIDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterPOIDetail().environmentObject(ModuleInfo())
    }
}
