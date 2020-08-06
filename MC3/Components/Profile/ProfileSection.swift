//
//  ProfileSection.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ProfileSection<Content: View>: View {
    var title:String?
    let content: Content
    var paddingTopSize:CGFloat = 15
    var paddingBottomSize:CGFloat = 30
    init(_ title:String? = nil, paddingBottomSize:CGFloat? = 30, paddingTopSize:CGFloat? = 30,@ViewBuilder content: () -> Content) {
        self.content = content()
        if let paddB = paddingBottomSize {
             self.paddingBottomSize = paddB
        }
        if let paddT = paddingTopSize {
            self.paddingTopSize = paddT
        }
        self.title = title
    }
    var body: some View {
        VStack(alignment: .leading){
            TitleText(content: "\(title ?? "")", type: .h2).padding(.top, paddingTopSize)
            VStack{
                self.content
            }
        }
        .padding(.horizontal,30)
        .padding(.bottom, paddingBottomSize)
        .background(Color.white)
        .cornerRadius(10)
    }
}

struct ProfileSection_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSection("Just Example"){
            Text("Just Example")
        }
    }
}
