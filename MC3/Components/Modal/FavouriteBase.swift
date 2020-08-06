//
//  FavouriteBase.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct FavouriteBase<Content:View>: View {
    var title:String
    var addFunction:(()->Void)?
    let content: Content
       
    init(title:String, addFunction:(()->Void)? = nil, @ViewBuilder content: () -> Content) {
           self.content = content()
           self.title = title
           self.addFunction = addFunction
    }
    var body: some View {
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center, spacing: 0){
                HStack{
                    Text(title).font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(height: 66)
                    Spacer()
                    if self.addFunction != nil {
                        Button(action: {
                            self.addFunction!()
                        }){
                            Text("ADD")
                            .font(.system(size: 15, weight: .bold, design: .rounded))
                            .foregroundColor(.nightSky)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(Color.pastelGold)
                            .cornerRadius(10)
                        }
                    }
                }.padding(.horizontal,30)
                .padding(.top,10)
                .padding(.bottom,20)
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

struct FavouriteBase_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteBase(title: "My Modules", addFunction: {}){
            Text("Testing")
        }
    }
}
