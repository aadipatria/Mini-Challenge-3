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
    @ObservedObject var dataCenter:DataCenter = DataCenter.getInstance()
    var body: some View {
        FavouriteBase(title: "My Modules", addFunction: {
            self.dataCenter.addModules(module: ModulesStub.getPlainModule())
        }){
            searchBar(inputBinding: $input, withCancel: false, disabled: false)
            Underline().padding(.top,20)
            if self.dataCenter.getCurrentUserModule().count < 1{
                ModuleEmptyState(title: "No created modules", content: "You haven’t created any modules yet. Try creating one by clicking the “add” button!")
            } else {
                ListOfModules(modules: self.filterModule(input: self.input, modules: self.dataCenter.getCurrentUserModule()))
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

