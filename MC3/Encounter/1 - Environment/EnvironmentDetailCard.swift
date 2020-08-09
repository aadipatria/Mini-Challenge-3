//
//  EnvironmentDetailCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EnvironmentDetailCard: View {
    var weather: String
    var terrain: String
    var description: String
    var image: UIImage?
    var actionDelete: () -> () = {}
    var actionEdit: () -> () = {}
    
    var body: some View {
        VStack(spacing: 0) {
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
            .padding(.bottom, 10)
            .padding(.horizontal, 30)
            
            HStack(spacing: 5) {
                Text("Terrain:")
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                
                Text(terrain)
                    .font(.system(size: 21, weight: .regular, design: .rounded))
                
                Spacer()
            }
            .padding(.bottom, 30)
            .padding(.horizontal, 30)
            
            HStack {
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: UIScreen.main.bounds.width - 80)
                        //.padding(.horizontal, 40)
                        .padding(.bottom, 30)
                }
            }
        
            HStack {
                if image != nil {
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
    
//    func getImage() -> String {
//        if let imageName = image {
//            return imageName
//        } else {
//            return ""
//        }
//    }
}

struct EnvironmentDetailCard_Preview: PreviewProvider {
    static var previews: some View {
        EnvironmentDetailCard(weather: "Cloudy", terrain: "Terraria", description: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.", image: UIImage(named: "OverviewLarge")!)
    }
}
