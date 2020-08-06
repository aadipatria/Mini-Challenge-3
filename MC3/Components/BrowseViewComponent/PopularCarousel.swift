//
//  PopularCarousel.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct PopularCarousel: View {
    var authors:[AuthorModel]
    @Binding var selected:AuthorModel
    @Binding var changePage:Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 15){
                ForEach(authors){author in
                    Button(action: {
                        self.selected = author
                        self.changePage = true
                    }) {
                        self.setPopularCard(author: author)
                    }.buttonStyle(PlainButtonStyle())
                    
                }
            }.padding(.horizontal, 30)
            if authors.count < 1 {
                PopularCard(author: AuthorStub.getPlainUser())
                    .frame(width: 165, height: 165)
                    .padding(.horizontal, 30)
            }
        }
    }
    func setPopularCard(author:AuthorModel)-> some View{
        PopularCard(author: author)
            .frame(width: 165, height: 165)
    }
}


struct PopularCard: View {
    var author:AuthorModel
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            PopularContentWrapper(author: author.name, moduleCount: 3, bestModule: "Enter Dragon")
            .frame(width: 93, height: 165)
            .background(LinearGradient(gradient: Gradient(colors:
                [.white,
                 Color.init(red: 191/255, green: 191/255, blue: 191/255, opacity: 1),
                 ]
            ), startPoint: .leading, endPoint: .trailing))
            PopularFadeImage(image: Image(author.profileImage))
        }
        .cornerRadius(10)
    }
}

struct PopularContentWrapper: View {
    var author:String
    var moduleCount:Int
    var bestModule:String
    var body: some View{
        VStack(alignment: .leading, spacing: 27.58){
            ContentText(content: author, size: .big)
            PopularContent(title: "Modules Made", content: "\(moduleCount) Modules")
            PopularContent(title: "Best Module", content: bestModule)
        }.padding(.horizontal, 6)
    }
}

struct PopularCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PopularCarousel(authors: AuthorStub.getAllAuthor(), selected: .constant(AuthorStub.getPlainUser()), changePage:.constant(false))
    }
}

struct PopularGreyText: View {
    var content:String
    var body: some View {
        Text(content).font(.system(size: 11, weight: .medium, design: .rounded))
            .foregroundColor(.gray)
    }
}

struct PopularContent: View {
    var title:String
    var content:String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            PopularGreyText(content: self.title)
            ContentText(content: self.content, size: .normal)
        }
    }
}


struct PopularFadeImage: View {
    var image:Image
    var body: some View {
        image.resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 72, height: 168, alignment: .center)
            .overlay(LinearGradient(gradient: Gradient(colors:
                [Color.init(red: 191/255, green: 191/255, blue: 191/255, opacity: 1),
                 .clear]
            ), startPoint: .leading, endPoint: .trailing))
            .clipped()
    }
}
