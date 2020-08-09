//
//  EncounterMapsDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMapsDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var mapsEditing: Int?
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var image: UIImage = UIImage(named: "OverviewSample")!
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterMapsEdit(editMode: .edit),
                tag: -1,
                selection: $mapsEditing
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
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].maps?.remove(at: self.moduleInfo.mapsIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.mapsEditing = -1}
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
            if let maps = encounter.maps?[self.moduleInfo.mapsIndex] {
                self.title = maps.name
                self.description = maps.desc
                self.image = maps.image
            }
        })
    }
}

struct EncounterMapsDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMapsDetail().environmentObject(ModuleInfo())
    }
}
