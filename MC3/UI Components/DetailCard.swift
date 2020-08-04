//
//  DetailCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 02/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DetailCard: View {
    var title: String
    var description: String
    var image: String?
    var actionDelete: () -> ()
    var actionEdit: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 15) {
                Text(title)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                Spacer()
                
                DeleteButton(action: {})
                
                EditButton(action: {})
            }
            .padding(.top, 20)
            .padding(.bottom, 30)
            .padding(.horizontal, 30)
            
            HStack {
                if getImage() != "" {
                    Image(image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        //.padding(.horizontal, 40)
                        .padding(.bottom, 30)
                }
            }
        
            HStack {
                if getImage() != "" {
                    Text(description)
                        .font(.system(size: 13, weight: .regular, design: .rounded))
                } else {
                    Text(description)
                        .font(.system(size: 15, weight: .regular, design: .rounded))
                }
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color.white)
    }
    
    func getImage() -> String {
        if let imageName = image {
            return imageName
        } else {
            return ""
        }
    }
}

struct DetailCard_Preview: PreviewProvider {
    static var previews: some View {
        DetailCard(title: "Title", description: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.", image: "OverviewLarge", actionDelete: {}, actionEdit: {})
    }
}
