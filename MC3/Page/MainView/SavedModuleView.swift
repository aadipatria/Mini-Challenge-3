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
    @State var input:String = ""
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    var body: some View {
        FavouriteBase(title: "Saved Modules"){
            searchBar(inputBinding: $input, withCancel: false, disabled: false)
            Underline().padding(.top,20)
            ListOfModules(modules:
                self.input.count > 0 ?
                self.filterModule(input: self.input, modules: self.modules) :
                modules)
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

struct SavedModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SavedModuleView(tabBarVisible: .constant(true))
    }
}
