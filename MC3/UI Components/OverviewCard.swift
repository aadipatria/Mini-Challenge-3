//
//  OverviewCard.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct OverviewCard: View {
    var title: String = "Title"
    var description: String = ""
    var image: URL = URL(fileURLWithPath: Bundle.main.path(forResource: "OverviewSample", ofType: "png")!)
    var actionDelete: () -> () = {}
    var actionEdit: () -> () = {}
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 23, weight: .medium, design: .rounded))
                Spacer()
                
                //if dataCenter.getActiveUser()?.id == moduleInfo.currentModule.author.id {
                DeleteButton(action: actionDelete)
                EditButton(action: actionEdit)
            }
            .padding(.top, 25)
            .padding(.bottom, 15)
            .padding(.horizontal, 30)
            
            HStack(alignment: .center) {
                getImageFromURL(url: image)
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
                .fill(Color.clear)
                .frame(width: UIScreen.main.bounds.width, height: 1)
        }
        .background(Color.white)
        .frame(width: UIScreen.main.bounds.width, height: 295)
        .cornerRadius(10)
    }
    
    func getImageFromURL(url: URL) -> Image {
        do {
            let imageData = try Data(contentsOf: url)
            return(Image(uiImage: UIImage(data: imageData) ?? UIImage()))
        } catch {
//            print("Unable to load data: \(error)")
        }
        
        return Image("OverviewSample")
    }
}
