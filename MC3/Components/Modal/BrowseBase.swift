//
//  BrowseBase.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct BrowseBase<Content:View>: View {
    var onTapProfile:(()->Void)?
    var title:String
    var profilePicture:String
    let content: Content
       
    init(onTapProfile:(()->Void)? = nil ,title:String, profile:String, @ViewBuilder content: () -> Content) {
            self.content = content() 
            self.title = title
            self.profilePicture = profile
            self.onTapProfile = onTapProfile
    }
    var body: some View {
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center, spacing: 0){
                HeaderElement(action: self.onTapProfile,pictureName: self.profilePicture, title: title)
                ZStack(alignment: .top){
                    ModalCard(color: .dewBlue)
                    VStack(alignment: .leading, spacing: 0){
                        self.content
                    }
                }
            }
        }
    }
}

struct BrowseBase_Previews: PreviewProvider {
    static var previews: some View {
        BrowseBase(title: "test", profile: "people"){
            Text("text")
        }
    }
}
