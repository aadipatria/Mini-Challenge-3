//
//  ModuleListScroll.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModuleListScroll: View {
    var modules:[ModuleModel]
    @Binding var isPreview:Bool
    @ObservedObject var dataCenter:DataCenter
    @EnvironmentObject var moduleInfo:ModuleInfo
    @Binding var isLogin:Bool
    
    init(modules:[ModuleModel], isPreview:Binding<Bool>, dataCenter:DataCenter, isLogin:Binding<Bool>) {
        self.modules = modules
        self._isLogin = isLogin
        self._isPreview = isPreview
        self.dataCenter = dataCenter
    }
    var body: some View {
        ZStack{
            if modules.count > 0 {
                ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .center, spacing: 30) {
                            ForEach(modules){ module in
                                ModuleGenreCard(module: module, isSaved: self.dataCenter.isSavedModule(id: module.id), dataCenter: self.dataCenter, isLogin: self.$isLogin).onTapGesture(perform: {
                                    self.moduleInfo.currentModule = module
                                    self.isPreview = true
                                })
                            }
                        }.padding(.bottom, 20)
                    
                }.padding(.top, 20).zIndex(1)
            }
        }
    }
}

struct ModuleListScroll_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListScroll(modules: ModulesStub.getModules(), isPreview: .constant(true), dataCenter: DataCenter(), isLogin: .constant(true))
    }
}
