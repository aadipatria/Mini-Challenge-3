//
//  EncounterMonstersList.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterMonstersList: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    @State private var monstersID: Int?
    @State private var monstersEditing: Int?
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(
                destination: EncounterMonstersEdit(editMode: editMode),
                tag: -1,
                selection: $monstersEditing
            ){ EmptyView() }
            
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                
                VStack(spacing: 0) {
                    EncounterHeader(
                        section: .Monsters,
                        isEditable: true,
                        action: {self.monstersEditing = -1})
                    
                    ScrollView {
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .frame(height: CGFloat((self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].monsters?.count ?? 0) * 134 + 30))
                                
                            VStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color.separator)
                                    .frame(width: UIScreen.main.bounds.width, height: 1)
                                
                                ForEach(0..<(self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].monsters?.count ?? 1), id: \.self) { (index) in
                                    NavigationLink(
                                        destination: EncounterMonstersDetail(),
                                        tag: index,
                                        selection: self.monstersBinding(index)
                                    ) {
                                        self.getContentCard(index)
                                        }.buttonStyle(PlainButtonStyle())
                                    .foregroundColor(Color.black)
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
    
    private func monstersBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.monstersID
        }, set: {
            self.moduleInfo.monsterIndex = index
            self.monstersID = $0
        })
        return binding
    }
    
    private func getContentCard(_ index: Int) -> PictureContentCard {
        let encounter = self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex]
        if let monster = encounter.monsters?[index] {
            return PictureContentCard(
                title: monster.name,
                description: monster.desc,
                image: monster.image,
                actionDelete: {
                    self.moduleInfo.currentModule.content.encounters[self.moduleInfo.encounterIndex].monsters?.remove(at: index)
                    self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                },
                actionEdit: {
                    self.moduleInfo.monsterIndex = index
                    self.editMode = .edit
                    self.monstersEditing = -1
                }
            )
        } else {
            return PictureContentCard(title: "Name", subtitle: "", description: "Description", image: URL(fileURLWithPath:""), actionDelete: {}, actionEdit: {})
        }
    }
}

struct EncounterMonstersList_Previews: PreviewProvider {
    static var previews: some View {
        EncounterMonstersList().environmentObject(ModuleInfo())
    }
}
