//
//  OverviewDetail.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct OverviewDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var overviewEditing: Bool
    @State private var overviewName: String = ""
    @State private var overviewImage: UIImage = UIImage(named: "OverviewLarge")!
    @State private var overviewDescription: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ModuleHeader(action: {self.presentationMode.wrappedValue.dismiss()})
            
            ZStack {
                BackgroundCard()
                    
                ScrollView {
                    DetailCard(
                        title: overviewName,
                        description: overviewDescription,
                        image: overviewImage,
                        actionDelete: {
                            self.moduleInfo.currentModule.content.overviews.remove(at:self.moduleInfo.overviewIndex)
                            self.dataCenter.saveModule(module: self.moduleInfo.currentModule)
                            self.presentationMode.wrappedValue.dismiss()
                        },
                        actionEdit: {
                            self.presentationMode.wrappedValue.dismiss()
                            self.overviewEditing = true
                        }
                    )
                    .padding(.top, 32)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        .onAppear(perform: {
            let overview = self.moduleInfo.currentModule.content.overviews[self.moduleInfo.overviewIndex]
            self.overviewName = overview.name
            self.overviewImage = overview.image
            self.overviewDescription = overview.desc
        })
    }
}
