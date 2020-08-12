//
//  SavedModuleView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 30/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct SavedModuleView: View {
    @Binding var tabBarVisible:Bool
    @State var myModule:[ModuleModel] = []
    @State var isPreview:Bool = false
    @State var input:String = ""
    @State var isAlert = false
    @ObservedObject var dataCenter = DataCenter.getInstance()
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    var body: some View {
        ZStack{
            FavouriteBase(title: "Saved Module"){
                searchBar(inputBinding: $input, withCancel: false, disabled: false)
                Underline().padding(.top,20)
                if myModule.count < 1{
                    ModuleEmptyState(title: "No Saved Modules", content: "There are no saved modules yet. Try exploring other modules you might be interested in!")
                } else {
                    ListOfModules(modules: self.filterModule(input: self.input, modules: self.myModule), isPreview: $isPreview)
                }
            }.onAppear{
                self.myModule = self.dataCenter.getCurrentUserModule().filter{ module in
                    if self.dataCenter.isSavedModule(id: module.id) {
                        print(module)
                        return true
                    }
                    return false
                }
            }
            
        if isPreview {
                ModuleMain(isActive: $isPreview)
                .zIndex(3)
            }
        }
        
    }
    func filterModule(input:String, modules:[ModuleModel])->[ModuleModel]{
        if input == "" { return modules }
        return modules.filter{ module in
            return
                module.name.uppercased().contains(input.uppercased()) ||
                    module.author.name.uppercased().contains(input.uppercased()) ||
                "\(module.level)".uppercased().contains(input.uppercased()) ||
                "\(module.genre)".uppercased().contains(input.uppercased())
        }
    }
}

struct SavedModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SavedModuleView(tabBarVisible: .constant(true))
    }
}
