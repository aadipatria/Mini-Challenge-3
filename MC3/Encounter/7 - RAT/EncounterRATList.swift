//
//  EncounterRATList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterRATList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var ratID: Int?
    @State private var ratEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterRATEdit(editMode: editMode),
                tag: -1,
                selection: $ratEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .ReadAloudText,
                        isEditable: true,
                        action: {self.ratEditing = -1})
                    
                    ScrollView {
                        ZStack {
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.white)
                                    .cornerRadius(10)
                                    .frame(height: CGFloat((self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].readAloudText?.count ?? 0) * 134 + 30))
                                    //TODO: Programatically edit height
                            }
                            
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.separator)
                                    .frame(width: UIScreen.main.bounds.width, height: 1)
                                
                                ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].readAloudText?.count ?? 1), id: \.self) { (index) in
                                    NavigationLink(
                                        destination: EncounterRATDetail(),
                                        tag: index,
                                        selection: self.ratBinding(index)
                                    ) {
                                        self.getContentCard(index)
                                        }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(Color.black)//
                                }
                            }
                            .padding(.vertical, 20)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    private func ratBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.ratID
        }, set: {
            self.moduleInfo.ratIndex = index
            self.ratID = $0
        })
        return binding
    }
    
    private func getContentCard(_ index: Int) -> ContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let rat = encounter.readAloudText?[index] {
            return ContentCard(
                title: rat.name,
                description: rat.desc,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].readAloudText?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.ratIndex = index
                    self.editMode = .edit
                    self.ratEditing = -1
                }
            )
        } else {
            return ContentCard(title: "", description: "", actionDelete: {}, actionEdit: {})
        }
    }
}

struct EncounterRATList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterRATList().environmentObject(ModuleInfo())
    }
}
