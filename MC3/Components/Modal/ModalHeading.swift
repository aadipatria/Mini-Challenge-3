//
//  ModalHeading.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModalHeading: View {
    var clickFunc:(()->Void)? = nil
    var title:String
    var body: some View {
        ZStack(alignment: .leading){
            Text("\(title)")
                .font(.system(size: 24, weight:.semibold))
                .foregroundColor(Color.white)
                .frame(width: screen.width - 30)
            BackButton(clickFunc: clickFunc)
        }
    }
}

struct ModalHeading_Previews: PreviewProvider {
    static var previews: some View {
        //      Black background only for showing purpose
        ModalHeading( title: "testing").background(Color.black)
    }
}
