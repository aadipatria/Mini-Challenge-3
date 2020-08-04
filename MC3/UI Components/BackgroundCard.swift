//
//  BackgroundCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct BackgroundCard: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
            
            Rectangle()
                .fill(Color.backgroundCard)
                .frame(minWidth: UIScreen.main.bounds.width, idealHeight: UIScreen.main.bounds.height - 140, maxHeight: .infinity)
                .cornerRadius(20)
                .edgesIgnoringSafeArea(.bottom)
        }
        .onTapGesture {
            ModuleInfo.endEditing()
        }
    }
}

struct BackgroundCard_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundCard()
    }
}
