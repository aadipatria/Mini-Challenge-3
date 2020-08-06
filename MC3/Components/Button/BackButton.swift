//
//  BackButton.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct BackButton: View {
    var clickFunc:(()->Void)? = nil
    var body: some View {
        Button(action: {
            if let action = self.clickFunc {
                action()
            }
        }) {
            Image(systemName: "arrow.left")
                .font(.system(size: 19, weight: .semibold))
                .foregroundColor(Color.white).multilineTextAlignment(.center)
                .padding(.all, 30)
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
//      Black background only for showing purpose
        BackButton().background(Color.black)
    }
}
