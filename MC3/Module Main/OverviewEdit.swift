//
//  OverviewEdit.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct OverviewEdit: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    @Binding var overviewName: String
    @Binding var overviewImage: UIImage
    @Binding var overviewDescription: String
    @State var editMode: EditMode
    @State var descriptionPlaceholder: String = "Description"
    
    var actionCancel: () -> ()
    var actionNext: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 306)
                    .cornerRadius(10)
                    .onTapGesture {ModuleInfo.endEditing()}
                
                VStack(spacing: 10) {
                    SingleLineField(
                        description: "Map or Image Name",
                        image: "TextfieldMapsPOI",
                        inputText: $overviewName)
                        .padding(.top, 20)
                    
                    UploadImageButton(image: $overviewImage)
                    
                    MultiLineField(
                        description: descriptionPlaceholder,
                        inputText: $overviewDescription)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 30) {
                        if self.moduleInfo.currentModule.content.overviews.count > 0 {
                            CancelButton(action: actionCancel)
                        }
                        NextButton(action: actionNext)
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                }
            }.onAppear(perform: {
                if self.editMode == .edit {
                    let index = self.moduleInfo.overviewIndex
                    let overview = self.moduleInfo.currentModule.content.overviews[index]
                    self.overviewName = overview.name
                    self.overviewImage = overview.image
                    self.overviewDescription = overview.desc
                    
                    if overview.desc != "" {
                        self.descriptionPlaceholder = ""
                    }
                }
            })
            
            Spacer()
        }
    }
}
