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
    var subtitle: String = ""
    var description: String
    var image: URL?
    var isClipped: Bool = false
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
                
                //if dataCenter.getActiveUser()?.id == moduleInfo.currentModule.author.id {
                DeleteButton(action: actionDelete)
                    .padding(.trailing, 10)
                EditButton(action: actionEdit)
            }
            .padding(.top, 20)
            .padding(.horizontal, 30)
            
            HStack {
                if image != nil {
                    if isClipped {
                        getImageFromURL(url: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .padding(.top, 30)
                    } else {
                        getImageFromURL(url: image!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: UIScreen.main.bounds.width - 80)
                            .padding(.top, 30)
                    }
                } else {
                    EmptyView()
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
            .padding(.vertical, 30)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color.white)
    }
    
    func getImageFromURL(url: URL) -> Image {
        do {
            let imageData = try Data(contentsOf: url)
            return(Image(uiImage: UIImage(data: imageData) ?? UIImage()))
        } catch {}
        
        return Image("OverviewSample")
    }
}

//struct DetailCard_Preview: PreviewProvider {
//    static var previews: some View {
//        DetailCard(title: "Title", subtitle: "Subtitle", description: "Most conventional modern houses in Western cultures will contain one or more bedrooms and bathrooms, a kitchen or cooking area, and a living room. A house may have a separate dining room, or the eating area may be integrated into another room. Some large houses in North America have a recreation room.", image: UIImage(named: "OverviewLarge")!, actionDelete: {}, actionEdit: {})
//    }
//}
