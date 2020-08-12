//
//  OverviewMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct OverviewMain: View {
    @EnvironmentObject var moduleInfo : ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @State private var overviewName: String = ""
    @State private var overviewImage: URL = URL(fileURLWithPath:"")
    @State private var overviewDescription: String = ""
    
    @State private var overviewID: Int?
    @State private var overviewEditing: Bool = false
    @State private var editMode: EditMode = .add
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleSegmentHeader(
                title: "Add a new Map or Image",
                action: {
                    self.editMode = .add
                    self.overviewName = ""
                    self.overviewDescription = ""
                    self.overviewEditing = true},
                isEditable: !self.overviewEditing)
            
            if overviewEditing {
                OverviewEdit(
                    overviewName: $overviewName,
                    overviewImage: $overviewImage,
                    overviewDescription: $overviewDescription,
                    editMode: .add,
                    actionCancel: {
                        self.editMode = .add
                        self.overviewEditing = false
                    },
                    actionNext: {
                        let index = self.moduleInfo.overviewIndex

                        if self.editMode == .add {
                            self.moduleInfo.currentModule.content.overviews.append(Overview(name: self.overviewName, image: self.overviewImage, desc: self.overviewDescription))
                        } else if self.editMode == .edit {
                            self.moduleInfo.currentModule.content.overviews[index].name = self.overviewName
                            self.moduleInfo.currentModule.content.overviews[index].image = self.overviewImage
                            self.moduleInfo.currentModule.content.overviews[index].desc = self.overviewDescription
                        }

                        self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                        self.overviewEditing = false
                })
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(0..<moduleInfo.currentModule.content.overviews.count, id: \.self) { (index) in
                            NavigationLink(
                                destination: OverviewDetail(
                                    overviewEditing: self.$overviewEditing),
                                tag: index,
                                selection: self.overviewBinding(index)
                            ) {
                                self.getOverviewCard(index)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear(perform: {
            if self.moduleInfo.currentModule.content.overviews.count < 1 {
                self.overviewEditing = true
            }
        })
    }
    
    func overviewBinding(_ index: Int) -> Binding<Int?> {
        let binding = Binding<Int?>(get: {
            self.overviewID
        }, set: {
            self.moduleInfo.overviewIndex = index
            self.overviewID = $0
        })
        return binding
    }
    
    func getOverviewCard(_ index: Int) -> OverviewCard {
        let overview = self.moduleInfo.currentModule.content.overviews[index]
        return OverviewCard(
            title: overview.name,
            description: overview.desc,
            image: overview.image,
            actionDelete: {
                self.moduleInfo.currentModule.content.overviews.remove(at: index)
                self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                
                if self.moduleInfo.currentModule.content.overviews.count < 1 {
                    self.overviewEditing = true
                }
            },
            actionEdit: {
                self.moduleInfo.overviewIndex = index
                self.overviewName = overview.name
                self.overviewImage = overview.image
                self.overviewDescription = overview.desc
                self.editMode = .edit
                self.overviewEditing = true
            }
        )
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        OverviewMain()
    }
}
