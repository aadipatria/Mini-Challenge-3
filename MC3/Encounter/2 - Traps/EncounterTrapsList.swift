//
//  EncounterTrapsList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterTrapsList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var trapID: Int?
    @State private var trapEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterTrapsEdit(editMode: editMode),
                tag: -1,
                selection: $trapEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .Traps,
                        isEditable: true,
                        action: {self.trapEditing = -1})
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color.separator)
                                .frame(width: UIScreen.main.bounds.width, height: 1)
                            
                            ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].traps?.count ?? 1), id: \.self) { (index) in
                                NavigationLink(
                                    destination: EncounterTrapsDetail(),
                                    tag: index,
                                    selection: self.trapsBinding(index)
                                ) {
                                    self.getContentCard(index)
                                    }.buttonStyle(PlainButtonStyle())
                                .foregroundColor(Color.black)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func trapsBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.trapID
        }, set: {
            self.moduleInfo.trapIndex = index
            self.trapID = $0
        })
        return binding
    }
    
    private func getContentCard(_ index: Int) -> TrapContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let trap = encounter.traps?[index] {
            return TrapContentCard(
                trapName: trap.name,
                trapThreat: trap.threat,
                trapTrigger: trap.trigger,
                trapEffect: trap.effect,
                trapLevel: trap.level,
                trapCountermeasure: trap.counterMeasure,
                trapDescription: trap.desc,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].traps?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.trapIndex = index
                    self.editMode = .edit
                    self.trapEditing = -1
                }
            )
        } else {
            return TrapContentCard(trapName: "Trap", trapThreat: "", trapTrigger: "", trapEffect: "", trapLevel: "", trapCountermeasure: "", trapDescription: "", actionDelete: {}, actionEdit: {})
        }
    }
}

struct EncounterTrapsList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterTrapsList().environmentObject(ModuleInfo())
    }
}
