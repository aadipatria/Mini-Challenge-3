//
//  ExampleUI.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 02/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ExampleUI: View {
    @ObservedObject var dataCenter = DataCenter() // untuk ngambil dan nyimpan data, untuk function yang available coba jump to definition
    var body: some View {
        VStack{
            ForEach(dataCenter.getAllModules()){ module in
                Text("\(module.name)")
            }
            Button(action: {
                // disini kita akan membuat module
                //let moduleContent = ModuleContent(overviews: [], encounters: [], environments: [], notes: [])
                let moduleContent = ModuleContent(overviews: [], encounters: [], notes: [])
                let module = ModuleModel(name: "Lorem", author: self.dataCenter.getActiveUser(), coverImageName: "people", addDate: Date.init(), level: .easy, genre: .horror, content: moduleContent)
                // dataCenter.getActiveUser adalah function untuk dapatin data user yang lagi login
                // disini kita akan nambahin module ke DB
                self.dataCenter.addModules(module: module)
//                print(self.dataCenter.getAllModules())
            }) {
                Text("Add New Module")
            }.padding(.top,30)
        }
    }
}

struct ExampleUI_Previews: PreviewProvider {
    static var previews: some View {
        ExampleUI()
    }
}
