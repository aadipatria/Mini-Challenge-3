//
//  ScreenMain.swift
//  MC3
//
//  Created by Peter Andrew on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DMScreenMain: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                OverviewCard()
                OverviewCard()
            }
        }
    }
}

struct ScreenMain_Previews: PreviewProvider {
    static var previews: some View {
        DMScreenMain()
    }
}
