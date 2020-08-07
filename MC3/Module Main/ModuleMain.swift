//
//  ModuleMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleMain: View {
    @Binding var isActive:Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter.getInstance()
    
    var body: some View {
        ZStack{
            
            NavigationView {
                VStack(spacing: 0) {
                    ModuleHeader(action: {
                        self.isActive = false
                    })
                    
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
}

struct ModuleMain_Previews: PreviewProvider {
    static var previews: some View {
        ModuleMain(isActive: .constant(true)).environmentObject(ModuleInfo())
    }
}
