//
//  MyModuleView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct MyModuleView: View {
    @Binding var tabBarVisible:Bool
    @State var input:String = ""
    @State var isAddModuleView = false
    @State var isPreview:Bool = false
    @State var isAlert:Bool = false
    @State var isLogin:Bool = false
    @ObservedObject var dataCenter:DataCenter = DataCenter.getInstance()
    @EnvironmentObject var model:ModuleInfo
    var body: some View {
        ZStack{
            FavouriteBase(title: "My Modules", addFunction: {
                if self.dataCenter.getActiveUser() == nil {
                     self.isAlert = true
                } else {
                    self.isAddModuleView = true
                    self.tabBarVisible = false
                }
            }){
                searchBar(inputBinding: $input, withCancel: false, disabled: false)
                Underline().padding(.top,20)
                if self.dataCenter.getCurrentUserModule().count < 1{
                    ModuleEmptyState(title: "No created modules", content: "You haven’t created any modules yet. Try creating one by clicking the “add” button!")
                } else {
                    ListOfModules(modules: self.filterModule(input: self.input, modules: self.dataCenter.getCurrentUserModule()), isPreview: $isPreview)
                }
            }.alert(isPresented: $isAlert) {
                Alert(title: Text("Login Required"), message: Text("Sign Up or Login to Add Module"),
                      primaryButton: .default(Text("Sign In"), action: {
                        self.isLogin = true
                      }),
                      secondaryButton: .default(Text("Cancel")))
            }
            .zIndex(1)
            
            if isLogin {
                LoginPage(isActive: $isLogin, dataCenter: self.dataCenter)
                .modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
            if isAddModuleView{
                AddModule(isActive: $isAddModuleView, previewModule: $isPreview)
                    .zIndex(2).modifier(PageTransitionModifier())
                    .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            } else if isPreview {
                ModuleMain(isActive: $isPreview)
                .zIndex(3).modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
        }
    }
    
    func filterModule(input:String, modules:[ModuleModel])->[ModuleModel]{
        if input == "" { return modules}
        return modules.filter{ module in
            return
                module.name.uppercased().contains(input.uppercased()) ||
                module.author.name.uppercased().contains(input.uppercased()) ||
                "\(module.level)".uppercased().contains(input.uppercased()) ||
                "\(module.genre)".uppercased().contains(input.uppercased())
        }
    }
}



struct MyModuleView_Previews: PreviewProvider {
    static var previews: some View {
        MyModuleView(tabBarVisible: .constant(true))
    }
}

