//
//  OverviewMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct OverviewMain: View {
    var body: some View {
        VStack(spacing: 0) {
            ModuleSegmentHeader(
                title: "Overview",
                action: {})
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    OverviewCard()
                    OverviewCard()
                }
            }
        }
    }
}

struct OverviewCard: View {
    var title: String = "Overview Title"
    var description: String = "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room."
    var image: String = "OverviewSample"
    var actionDelete: () -> () = {}
    var actionEdit: () -> () = {}
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                Spacer()
                
                DeleteButton(action: actionDelete)
                
                EditButton(action: actionEdit)
            }
            .padding(.top, 25)
            .padding(.bottom, 15)
            .padding(.horizontal, 30)
            
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(minWidth: UIScreen.main.bounds.width - 80, maxHeight: 144)
                    .padding(.leading, 40)
            
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(Color.chevronNext)
                    .padding(.trailing, 17)
            }
            .padding(.bottom, 12)
            
            Text(description)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .padding(.horizontal, 40)
                .frame(maxHeight: 54, alignment: .leading)
            
            Spacer()
            Rectangle()
                .fill(Color.separator)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 295)
    }
}

struct Overview_Previews: PreviewProvider {
    static var previews: some View {
        OverviewMain()
    }
}
