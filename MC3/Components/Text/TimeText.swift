//
//  TimeText.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct TimeText: View {
    var date:Date
    var body: some View {
        HStack(spacing:0){
            Image(systemName: "clock")
                .font(.system(size: 13, weight: .light, design: .rounded))
            Text(AppsTime.generateTimeAgo(time: self.date)).font(.system(size: 13, weight: .light, design: .rounded))
        }
    }
}

struct TimeText_Previews: PreviewProvider {
    static var previews: some View {
        TimeText(date: Date.init())
    }
}
