//
//  HeaderName.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct HeaderElement: View {
    var action:(()->Void)?
    var pictureName:String
    var title:String
    var body: some View {
        HStack{
            Text(title).font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            Spacer()
            ProfilePicture(name: pictureName, purpose: .small)
                .onTapGesture {
                    if let action = self.action {
                        action()
                    }
            }
        }.padding(.horizontal,30)
        .padding(.top,10)
        .padding(.bottom,20)
    }
}

struct HeaderElement_Previews: PreviewProvider {
    static var previews: some View {
        HeaderElement(pictureName: "people", title: "test")
    }
}
