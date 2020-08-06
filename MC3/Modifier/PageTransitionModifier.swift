//
//  PageTransitionModifier.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct PageTransitionModifier: ViewModifier {
    var index:Double = 2
    func body(content: Content) -> some View {
        return content
            .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .slide))
            .animation(.easeInOut)
            .zIndex(index)
    }
}
