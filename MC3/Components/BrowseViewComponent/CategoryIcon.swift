//
//  CategoryIcon.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct CategoryData{
    var iconName:String
    var title:String
}

struct CategoryIcon: View {
    var categoryData:CategoryData
    var functionality:()->Void
    var body: some View {
        Button(action: functionality){
            VStack(spacing:10){
                Image(categoryData.iconName)
                    .cornerRadius(10)
                    .shadow(color: Color.init(red: 36/255, green: 42/255, blue: 73/255), radius: 2, x: 0, y: 2)
                ContentText(content: categoryData.title, size: .normal)
            }
            
        }.buttonStyle(PlainButtonStyle())
        .frame(width: (screen.width - 20) / 5)
    }
}

struct CategoryIcon_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIcon( categoryData: .init(iconName: "horrorIcon", title: "Horror"), functionality: {})
    }
}
