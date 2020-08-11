//
//  SearchModuleView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct SearchModuleView: View {
    @Binding var isActive:Bool
    @State var input:String = ""
    @State var isPreview:Bool = false
    @State var isAlert = false
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    @ObservedObject var dataCenter = DataCenter.getInstance()
    @State var isLogin = false
    var body: some View {
        ZStack{
            NavigationModalTemplate(title: "", modalColor: .white, heading: false){
                searchBar(inputBinding: $input, withCancel: true, cancelFunction: {
                    self.isActive = false
                })
                ModuleListScroll(modules: self.filterModule(input: self.input, modules: modules), isPreview: $isPreview, dataCenter: self.dataCenter, isLogin: $isAlert)
            }.alert(isPresented: $isAlert) {
                Alert(title: Text("Login Required"), message: Text("Sign Up or Login to Save Module"),
                      primaryButton: .default(Text("Sign In"), action: {
                        self.isLogin = true
                      }),
                      secondaryButton: .default(Text("Cancel")))
            }
            if isLogin {
                LoginPage(isActive: self.$isLogin, dataCenter: self.dataCenter).zIndex(2)
            } else if isPreview {
                ModuleMain(isActive: $isPreview)
                    .zIndex(3)
            }
        }
    }
    func filterModule(input:String, modules:[ModuleModel])->[ModuleModel]{
        return modules.filter{ module in
            return
                module.name.uppercased().contains(input.uppercased()) ||
                module.author.name.uppercased().contains(input.uppercased()) ||
                "\(module.level)".uppercased().contains(input.uppercased()) ||
                "\(module.genre)".uppercased().contains(input.uppercased())
            }
        }
}


struct SearchModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchModuleView(isActive: .constant(true))
    }
}
