//
//  TitleText.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

enum TitleType {
    case h1
    case h2
    case h3
    case h1p5wH
}

struct TitleText: View {
    var content:String
    var type:TitleType = .h2
    var body: some View {
        self.getText(content: content, type: type)
    }
    func getText(content:String, type:TitleType)-> some View{
        switch type {
        case .h1:
            return Text("\(content)")
                    .font(.system(size: 27, weight: .bold, design: .rounded))
        case .h2:
            return Text("\(content)")
                    .font(.system(size: 21, weight: .bold, design: .rounded))
        case .h3:
            return Text("\(content)")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
        case .h1p5wH:
            return Text("\(content)")
            .font(.system(size: 23, weight: .heavy, design: .rounded))
        }
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            TitleText(content: "Example Have Size of 27", type: .h1)
            TitleText(content: "Example Have Size of 23 and heavy", type: .h1p5wH)
            TitleText(content: "Example Have Size of 22", type: .h2)
            TitleText(content: "Example Have Size of 17", type: .h3)
        }
    }
}
