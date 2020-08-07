//
//  ListOfModules.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 30/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ListOfModules: View {
    @Binding var showPreview:Bool
    @EnvironmentObject var moduleInfo:ModuleInfo
    var modules:[ModuleModel]
    init(modules:[ModuleModel], isPreview:Binding<Bool>) {
        self.modules = modules
        self._showPreview = isPreview
    }
    var body: some View {
        ZStack{
            ScrollView(.vertical){
                Color.clear
            }
            if modules.count > 0 {
                ScrollView(.vertical){
                    ForEach(self.modules){ module in
                        moduleRow(module: module, last: self.isLastModule(module: module)).onTapGesture(perform: {
                            self.moduleInfo.currentModule = module
                            self.showPreview = true
                            
                        })
                    }
                    Underline()
                }
            }
        }
    }
    func isLastModule(module:ModuleModel)->Bool {
        let count = self.modules.count
        return count < 2 ? true :
            self.modules[count-1].id == module.id
    }
}

struct ListOfModules_Previews: PreviewProvider {
    static var previews: some View {
        ListOfModules(modules: [], isPreview: .constant(false))
    }
}
