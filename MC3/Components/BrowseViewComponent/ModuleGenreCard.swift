//
//  ModuleGenreCard.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ModuleGenreCard: View {
    @State var module:ModuleModel
    @State var isSaved:Bool = false
    @ObservedObject var dataCenter:DataCenter
    @Binding var isLogin:Bool
    var body: some View {
        VStack(alignment: .center, spacing: 30){
            VStack(alignment: .leading, spacing: 0){
                TitleText(content: module.name, type: .h1p5wH)
                    .padding(.bottom, 45)
                HStack(alignment: .center, spacing: 0) {
                    TitleText(content: "Level: ", type: .h3)
                        .foregroundColor(.lightGray)
                    TitleText(content: "\(module.level)".capitalized, type: .h3)
                }.padding(.bottom, 15)
                HStack(alignment: .bottom, spacing: 0){
                    Image("people")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 58, height: 70, alignment: .center)
                        .cornerRadius(5)
                        .clipped()
                        .padding(.trailing, 15)
                    VStack(alignment: .leading, spacing: 15){
                        ContentText(content: module.author.name, size: .normal)
                        TimeText(date: module.addDate)
                    }.padding(.bottom,8)
                    Spacer()
                    Button(action: {
                        if self.dataCenter.activeUser == nil {
                            self.isLogin = true
                        } else {
                            self.isSaved.toggle()
                            self.dataCenter.savedModule(id: self.module.id)
                        }
                    }) {
                        HStack(alignment: .center, spacing: 10){
                            Image(systemName: isSaved ? "bookmark" : "bookmark.fill")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                            ContentText(content: isSaved ? "Save" : "Saved", size: .normal)
                        }
                    }.buttonStyle(PlainButtonStyle())
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                        .background(Color.darkGray)
                        .cornerRadius(5)
                }
            }
            .foregroundColor(.white)
            .padding(.leading,20)
            .padding(.trailing,25)
            .frame(width: 334, height: 240, alignment: .leading)
            .background(
                ZStack{
                    Color.nightSky
                    Image(uiImage: ImageConverter.convURLtoData(url: module.coverImageName)).resizable().aspectRatio(contentMode: .fill).opacity(0.5)
                }
            )
                .cornerRadius(10)
        }
    }
}

struct ModuleGenreCard_Previews: PreviewProvider {
    static var previews: some View {
        ModuleGenreCard(module: ModulesStub.getModules()[0], isSaved: false, dataCenter: DataCenter(), isLogin: .constant(false))
    }
}
