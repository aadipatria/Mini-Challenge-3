//
//  RecentCaoursel.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct RecentCarousel: View {
    var modules:[ModuleModel]
    @Binding var isLogin:Bool
    @Binding var isPreview:Bool
    @EnvironmentObject var modulInfo:ModuleInfo
    @ObservedObject var dt = DataCenter.getInstance()
    @State var recentOffset:CGFloat = 0
    @State var lastRecentOffset:CGFloat = 0
    var tapGesture:TapGesture = TapGesture(count: 1)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0){
                ForEach(modules){module in
                    GeometryReader { geometry in
                        RecentCard(module: module, saveFunc: {cb in
                            if self.dt.getActiveUser() == nil {
                                self.isLogin = true
                            } else {
                                // save module
                                self.dt.savedModule(id: module.id)
                                (cb ?? {})()
                            }
                        }, preview: {
                            self.isPreview = true
                        }).animation(.easeInOut)
                        .scaleEffect(self.scalingFromPosition(pos: geometry.frame(in: .global).minX))
                    }.frame(width: 354, height: 130)
                        .offset(x: self.recentOffset, y: 0)
                        .animation(.spring())
                        .gesture(
                            DragGesture()
                            .onChanged { gesture in
                                self.onChangeHandler(gesture: gesture)}
                            .onEnded{ pos in
                                self.onEndedHandler(pos: pos)}
                            .exclusively(before: TapGesture())
                        )
                }
            }
            .padding(.leading, 30)
            if modules.count < 1 {
                RecentCard(isSaved: false, module:ModuleModel(name: "", author: AuthorStub.getActiveUser(), coverImageName: URL(fileURLWithPath: ""), addDate: Date.init(), level: .normal, genre: .action, content: ModulesStub.modulContent[0]), isSkeleton: true, saveFunc: {_ in }, preview: {})
                .padding(.leading, 30)
            }
        }
    }
    func onChangeHandler(gesture:DragGesture.Value)->Void{
        self.recentOffset = gesture.translation.width + self.lastRecentOffset
    }
    func onEndedHandler(pos:DragGesture.Value)->Void {
        let maxOffset = CGFloat(-354 * (self.modules.count - 1))
        if self.recentOffset > 0 {
            self.recentOffset = 0
        } else if self.recentOffset < maxOffset {
            self.recentOffset = maxOffset
        }
        self.recentOffset = round(self.recentOffset / 354) * 354
        self.lastRecentOffset =  self.recentOffset
    }
    func scalingFromPosition(pos:CGFloat)->CGFloat {
        var data = pos
        if data > 384 {
            return 0.9
        }
        if data >= 354 {
            data -= 384
            data = data < 0 ? data * -1 : data
        }
        let res =  data/30 * 0.1 + 0.9
        return res <= 0.9 ? 0.9 : res >= 1 ? 1 : res
    }
}


struct RecentCard: View {
    @State var isSaved:Bool = false
    var module:ModuleModel
    var isSkeleton:Bool = false
    @ObservedObject var dt = DataCenter.getInstance()
    var saveFunc:(_ cb:(()->Void)?)->Void
    var preview:()->Void
    @EnvironmentObject var mi:ModuleInfo
    
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            RecentCardImage(image: !isSkeleton ? Image( uiImage:  ImageConverter.convURLtoData(url: module.coverImageName)) : Image("moduleCover"))
            
                RecentCardImageOverlay().onTapGesture {
                    self.mi.currentModule = self.module
                    self.preview()
                }
           
            saveButton(isSaved: $isSaved, action: saveFunc)
            if !isSkeleton{
                RecentCardContent(module: module)
            }
        }.onAppear{
            self.isSaved = self.dt.isSavedModule(id: self.module.id)
        }
        .foregroundColor(.white)
        .frame(width: 354, height: 130, alignment: .bottomTrailing)
        .cornerRadius(10)
    }
}


struct RecentCarousel_Previews: PreviewProvider {
    static var previews: some View {
            RecentCarousel(modules: ModulesStub.getModules(),isLogin: .constant(true),isPreview: .constant(true))
    }
}

struct RecentCardImage: View {
    var image:Image
    var body: some View {
        HStack{
            Spacer()
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 354/2, height: 130, alignment: .center)
                .clipped()
        }
    }
}

struct RecentCardImageOverlay: View {
    var body: some View {
        Spacer().frame(width: 354, height: 130, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [
                .gradientBlueDark,
                .gradientBlueLight,
                Color.init(red:100/255, green: 100/255, blue: 100/255),
                Color.clear,
        ]), startPoint: .leading, endPoint: .trailing))
    }
}

struct RecentCardContent: View {
    var module:ModuleModel
    var body: some View {
        HStack(alignment: .top, spacing: 0){
            VStack(alignment: .leading,spacing:0){
                TitleText(content: module.name, type: .h3).padding(.top, 19)
                    .padding(.bottom, 21)
                HStack(alignment:.center, spacing:0){
                    Rectangle()
                        .frame(width: 2, height: 25)
                        .foregroundColor(Color.gold)
                        .padding(.trailing, 10)
                    VStack(alignment:.leading, spacing:1){
                        ContentText(content: self.module.author.name, size: .big)
                        TimeText(date: self.module.addDate).foregroundColor(.gold)
                    }
                }
                Spacer()
            }.padding(.leading, 25)
            Spacer()
        }
    }
}



struct saveButton: View {
    @Binding var isSaved:Bool
    var action:(_ cb:(()->Void)?)->Void
    var body: some View {
        VStack(alignment: .trailing, spacing: 0){
            Button(action: {
                self.action({
                    self.isSaved.toggle()
                })
            }) {
                HStack(alignment: .center, spacing: 20){
                    Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                    ContentText(content: isSaved ? "Saved" : "Save", size: .normal)
                }.foregroundColor(.black)
            }.buttonStyle(PlainButtonStyle())
                .padding(.vertical, 10)
                .padding(.horizontal, 30)
                .background(Color.gold)
                .cornerRadius(5)
                .padding(.trailing,15)
                .padding(.bottom,15)
        }
    }
}
