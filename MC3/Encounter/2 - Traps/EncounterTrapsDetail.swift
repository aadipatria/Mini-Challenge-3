//
//  EncounterTrapsDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTrapsDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var trapEditing: Int?
    @State private var trapName: String = ""
    @State private var trapThreat: String = ""
    @State private var trapTrigger: String = ""
    @State private var trapEffect: String = ""
    @State private var trapLevel: String = ""
    @State private var trapCountermeasure: String = ""
    @State private var trapDescription: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterTrapsEdit(editMode: .edit),
                tag: -1,
                selection: $trapEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    TrapContentCard(
                        trapName: self.trapName,
                        trapThreat: self.trapThreat,
                        trapTrigger: self.trapTrigger,
                        trapEffect: self.trapEffect,
                        trapLevel: self.trapLevel,
                        trapCountermeasure: self.trapCountermeasure,
                        trapDescription: self.trapDescription,
                        actionDelete: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].traps?.remove(at: self.moduleInfo.trapIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        },
                        actionEdit: {self.trapEditing = -1}
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
            if let trap = encounter.traps?[self.moduleInfo.trapIndex] {
                self.trapName = trap.name
                self.trapThreat = trap.threat
                self.trapTrigger = trap.trigger
                self.trapEffect = trap.effect
                self.trapLevel = trap.level
                self.trapCountermeasure = trap.counterMeasure
                self.trapDescription = trap.desc
            }
        })
    }
}

struct EncounterTrapsDetail_Previews: PreviewProvider {
    static var previews: some View {
        EncounterTrapsDetail().environmentObject(ModuleInfo())
    }
}
