//
//  ModuleListScroll.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModuleListScroll: View {
    @State var modules:[ModuleModel]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(alignment: .center, spacing: 30) {
                ForEach(modules){ module in
                    ModuleGenreCard(module: module)
                }
            }.padding(.bottom, 20)
        }.padding(.top, 20)
    }
}

struct ModuleListScroll_Previews: PreviewProvider {
    static var previews: some View {
        ModuleListScroll(modules: ModulesStub.getModules())
    }
}
