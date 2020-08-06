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
            // add module view
        }){
            searchBar(inputBinding: $input, withCancel: false, disabled: false)
            Underline().padding(.top,20)
            ListOfModules(modules: self.filterModule( input: self.input, modules: dataCenter.getCurrentUserModule()))
        }.onAppear{

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

struct MyModuleView_Previews: PreviewProvider {
    static var previews: some View {
        MyModuleView(tabBarVisible: .constant(true))
    }
}

