//
//  ContentText.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

enum ContentSize{
    case normal
    case semiTitle
    case big
}

struct ContentText: View {
    var content:String
    var size:ContentSize = .normal
    var body: some View{
        Text("\(self.content)")
            .font(.system(size: size == ContentSize.big ? 15 : size == ContentSize.semiTitle ? 20 : 13, weight: .medium, design: .rounded))
    }
}

struct ContentText_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentText(content: "Test Have Size of 15", size: .big
            )
            ContentText(content: "Test Have Size of 13", size: .normal
            )
        }
    }
}
