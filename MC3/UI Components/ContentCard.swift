//
//  ContentCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ContentCard: View {
    var title: String
    var description: String
    var actionDelete: () -> ()
    var actionEdit: () -> ()
    
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
            .padding(.bottom, 18)
            .padding(.horizontal, 30)
            
            HStack(alignment: .top) {
                Text(description)
                    .font(.system(size: 15, weight: .regular, design: .rounded))
                    .padding(.leading, 40)
                    .padding(.trailing, 56)
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 17, weight: .regular, design: .rounded))
                    .padding(.trailing, 30)
            }
            
            Spacer()
            Rectangle()
                .fill(Color.separator)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 124)
    }
}

struct EditSymbol: View {
    var body: some View {
        Image("EditSymbol")
            .resizable()
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
            .frame(width: 23, height: 22)
            .offset(x: 4, y: -3)
    }
}

struct ContentCard_Preview: PreviewProvider {
    static var previews: some View {
        ContentCard(title: "Title", description: "Description", actionDelete: {}, actionEdit: {})
    }
}
