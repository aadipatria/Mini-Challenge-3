//
//  ModalCard.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModalCard: View {
    var color:Color = Color.init(red: 244/255, green: 244/255, blue: 244/255)
    var body: some View {
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(20)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ModalCard_Previews: PreviewProvider {
    static var previews: some View {
        ModalCard()
    }
}
