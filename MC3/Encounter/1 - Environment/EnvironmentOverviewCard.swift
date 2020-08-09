//
//  EnvironmentOverviewCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EnvironmentOverviewCard: View {
    var weather: String
    var terrain: String
    var description: String
    var image: UIImage?
    var actionDelete: () -> () = {}
    var actionEdit: () -> () = {}
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 5) {
                Text("Weather:")
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                
                Text(weather)
                    .font(.system(size: 21, weight: .regular, design: .rounded))
                
                Spacer()
                
                //if dataCenter.getActiveUser()?.id == moduleInfo.currentModule.author.id {
                DeleteButton(action: actionDelete)
                    .padding(.trailing, 10)
                EditButton(action: actionEdit)
            }
            .padding(.top, 30)
            .padding(.horizontal, 30)
            
            HStack(spacing: 5) {
                Text("Terrain:")
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                
                Text(terrain)
                    .font(.system(size: 21, weight: .regular, design: .rounded))
                
                Spacer()
            }
            .padding(.horizontal, 30)
            
            HStack(alignment: .center) {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: UIScreen.main.bounds.width - 80, maxHeight: 144)
                        .frame(maxHeight: 144)
                        .padding(.leading, 40)
                }
            
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .foregroundColor(Color.chevronNext)
                    .padding(.trailing, 17)
            }
            
            Text(description)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .padding(.horizontal, 40)
            
            Spacer()
            Rectangle()
                .fill(Color.clear)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 385)
        .cornerRadius(10)
    }
}

struct EnvironmentOverviewCard_Preview: PreviewProvider {
    static var previews: some View {
        EnvironmentOverviewCard(weather: "Cloudy", terrain: "Terraria", description: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.", image: UIImage(named: "OverviewSample")!)
    }
}
