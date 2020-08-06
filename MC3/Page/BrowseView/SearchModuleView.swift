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
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    var body: some View {
        NavigationModalTemplate(title: "", modalColor: .white, heading: false){
            searchBar(inputBinding: $input, withCancel: true, cancelFunction: {
                self.isActive = false
            })
            ModuleListScroll(modules: modules)
        }
    }
}

struct SearchModuleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchModuleView(isActive: .constant(true))
    }
}
