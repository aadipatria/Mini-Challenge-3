//
//  ModuleMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleMain: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ModuleHeader(
                    module: moduleInfo.currentModule.name,
                    author: moduleInfo.currentModule.author.name,
                    image: moduleInfo.currentModule.author.image,
                    action: {})
                
                ZStack {
                    BackgroundCard()
                    ModuleSegment()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ModuleMain_Previews: PreviewProvider {
    static var previews: some View {
        ModuleMain().environmentObject(ModuleInfo())
    }
}
