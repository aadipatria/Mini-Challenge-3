//
//  PictureContentCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct PictureContentCard: View {
    var title: String
    var subtitle: String = ""
    var description: String
    var image: String
    var actionDelete: () -> ()
    var actionEdit: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .bottom, spacing: 5) {
                Text(title)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                
                Text(subtitle)
                    .font(.system(size: 19, weight: .light, design: .rounded))
                
                Spacer()
                
                DeleteButton(action: actionDelete)
                    .padding(.trailing, 10)
                
                EditButton(action: actionEdit)
            }
            .padding(.top, 20)
            .padding(.bottom, 5)
            .padding(.horizontal, 30)
            
            HStack(alignment: .center) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 60, height: 60)
                    
                Text(description)
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .frame(maxHeight: 45)
                    .padding(.leading, 15)
                    .padding(.trailing, 56)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
            }
            .padding(.horizontal, 30)
            
            Spacer()
            Rectangle()
                .fill(Color.separator)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 124)
    }
}

struct PictureContentCard_Preview: PreviewProvider {
    static var previews: some View {
        PictureContentCard(title: "Title", description: "Description Description Description Description Description Description Description Description Description", image: "EncounterMaps", actionDelete: {}, actionEdit: {})
    }
}
