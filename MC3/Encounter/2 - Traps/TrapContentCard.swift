//
//  TrapContentCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 05/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct TrapContentCard: View {
    var trapName: String
    var trapThreat: String
    var trapTrigger: String
    var trapEffect: String
    var trapLevel: String
    var trapCountermeasure: String
    var trapDescription: String
    
    var actionDelete: () -> ()
    var actionEdit: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Text(trapName)
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                Spacer()
                
                //if dataCenter.getActiveUser()?.id == moduleInfo.currentModule.author.id {
                DeleteButton(action: actionDelete)
                EditButton(action: actionEdit)
            }
            .padding(.top, 25)
            .padding(.bottom, 14)
            .padding(.horizontal, 30)
            
            getFields("Threat", content: trapThreat)
            getFields("Trigger", content: trapTrigger)
            getFields("Effect", content: trapEffect)
            getFields("Level", content: trapLevel)
            getFields("Countermeasure", content: trapCountermeasure)
            
            Text(trapDescription)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .frame(height: 100)
                .padding(.top, 10)
                .padding(.horizontal, 40)
            
            Spacer()
//            Rectangle()
//                .fill(Color.separator)
//                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(height: 364)
        .cornerRadius(10)
    }
    
    func getFields(_ parameter: String, content: String) -> AnyView {
        return AnyView(
            HStack(spacing: 5) {
                Text("\(parameter):")
                    .font(.system(size: 17, weight: .medium , design: .rounded))
                Text(content)
                    .font(.system(size: 17, weight: .regular , design: .rounded))
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 40))
    }
}

struct TrapContentCard_Preview: PreviewProvider {
    static var previews: some View {
        TrapContentCard(trapName: "Poison Darts", trapThreat: "Bombaria", trapTrigger: "Terraria", trapEffect: "Terraria", trapLevel: "Terraria", trapCountermeasure: "Terraria", trapDescription: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room. Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.", actionDelete: {}, actionEdit: {})
    }
}
