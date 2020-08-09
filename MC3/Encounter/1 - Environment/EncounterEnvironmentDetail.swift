//
//  EncounterEnvironmentDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterEnvironmentDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var environmentEditing: Int?
    @State private var weather: String = ""
    @State private var terrain: String = ""
    @State private var image: UIImage = UIImage(named: "OverviewLarge")!
    @State private var description: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterEnvironmentEdit(editMode: .edit),
                tag: -1,
                selection: $environmentEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    EnvironmentDetailCard(
                        weather: weather,
                        terrain: terrain,
                        description: description,
                        image: image,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].pois?.remove(at: self.moduleInfo.poiIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.environmentEditing = -1}
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
            if let environmentModel = encounter.environment?[self.moduleInfo.environmentIndex] {
                self.weather = environmentModel.weather
                self.terrain = environmentModel.terrain
                self.image = environmentModel.image
                self.description = environmentModel.desc
            }
        })
    }
}

struct EncounterEnvironmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterEnvironmentDetail().environmentObject(ModuleInfo())
    }
}
