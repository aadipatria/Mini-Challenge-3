//
//  ModuleEmptyState.swift
//  MC3
//
//  Created by Peter Andrew on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleEmptyState:View {
    var topPadding:CGFloat = 80
    var imageShow:Bool = true
    var title:String
    var content:String
    var body: some View{
        VStack(alignment: .center, spacing: 0){
            if imageShow {
                Image("emptyModule")
                .offset(x: -14, y: 0)
            }
            Text(title).font(.system(size: 18, weight: .bold, design: .rounded))
                .opacity(0.5)
                .padding(.top,20)
                .padding(.bottom,imageShow ? 10 : 20)
            Text(content)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .opacity(0.5)
                .multilineTextAlignment(.center).padding(.horizontal,80)
        }.frame(width: screen.width)
        .padding(.top,topPadding)
    }
}
struct ModuleEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        ModuleEmptyState(title: "No created modules", content: "You haven’t created any modules yet. Try creating one by clicking the “add” button!")
    }
}
