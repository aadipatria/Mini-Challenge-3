//
//  ProfileCardPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 24/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ProfileCardPage: View {
    var author:AuthorModel
    @State var secondModalPosition:CGFloat = 80
    @State var modalLastPosition:CGFloat = 80
    @State var modules:[ModuleModel] = []
    @Binding var isActive:Bool
    @ObservedObject var dataCenter = DataCenter.getInstance()
    var body: some View {
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center, spacing: 0){
                ModalHeading(clickFunc: {
                    self.isActive = false
                }, title: "")
                VStack(alignment: .center, spacing: 0){
                    ProfilePicture(name: self.author.profileImage, purpose: .normal).padding(.bottom,25)
                    Text(self.author.name.capitalized)
                        .font(.system(size: 29, weight: .bold, design: .rounded))
                        .foregroundColor(Color.white)
                                       
                }.padding(.top,40)
                .padding(.bottom,25)
                .onAppear{
                    self.modules = []
//                    self.dataCenter.getModuleWithUser(author: self.author)
                }
                ZStack(alignment: .top){
                    ProfileCardModal(bgColor: Color.init(red: 197/255, green: 211/255, blue: 220/255)){
                        TitleText(content: "Social Media", type: .h1).padding(30)
                        Underline()
                        SocialMediaShow(author: self.author)
                        Spacer()
                    }
                    ProfileCardModal(bgColor: .calmBlue){
                        ZStack{
                            ZStack(alignment: .topLeading){
                                TitleText(content: "Modules", type: .h1)
                                    .padding(30)
                                    .frame(width: screen.width,alignment: .leading)
                                    .background(Color.calmBlue)
                                Rectangle().foregroundColor(.clear)
                            }.frame(width:screen.width, alignment: .leading)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                    if self.secondModalPosition + 80 >= 80 && self.secondModalPosition <= 530 {
                                        self.secondModalPosition = gesture.translation.height + self.modalLastPosition
                                    }
                                }
                                .onEnded{ pos in
                                    if pos.translation.height >= 530/2{
                                        self.secondModalPosition = 460
                                    } else {
                                        self.secondModalPosition = 80
                                    }
                                    self.modalLastPosition = self.secondModalPosition
                                }
                            )
                            VStack(alignment: .center, spacing: 0){
                                TitleText(content: " ", type: .h1).padding(30)
                                Underline()
                                if modules.count > 0 {
                                    ScrollView(.vertical){
                                        ForEach(modules){ module in
                                            moduleRow(module: module, last: self.modules.count > 0 ? self.modules[self.modules.count - 1].id == module.id : false)
                                        }
                                    }
                                } else {
                                    ScrollView(.vertical){
                                        ModuleEmptyState(imageShow: false, title: "No Created Modules", content: "\(author.name) hasn’t created any modules to be shared yet :( \n\nFor the time being, let’s explore other great modules, shall we?")
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        
                    }.offset(x: 0, y: secondModalPosition)
                    .animation(.spring())
                }
            }
        }
    }
}

struct ProfileCardPage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardPage(author: AuthorStub.getActiveUser(), isActive: .constant(true))
    }
}

struct ProfileCardModal<Content: View>: View {
    var bgColor:Color
    let content: Content
    init(bgColor:Color = Color.white, @ViewBuilder content: () -> Content) {
        self.bgColor = bgColor
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            content
        }.frame(width: screen.width, alignment: .leading)
            .background(bgColor)
            .cornerRadius(20)
    }
}

struct moduleRow: View {
    var module:ModuleModel
    var last:Bool
    var body: some View {
        HStack(alignment:.center, spacing:0){
            Image(module.coverImageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()
            VStack(alignment: .leading,spacing:0){
                TitleText(content: module.name, type: .h2)
                ContentText(content: "Added on: \(changeDateFormat(date: module.addDate))", size: .normal)
                    .padding(.top,5)
                    .padding(.bottom, 10)
                ContentText(content: "Difficulty: \("\(module.level)".capitalized)", size: .big)
            }.padding(.leading,15)
            Spacer()
            Image(systemName: "chevron.right").font(.system(size: 17))
        }.padding(.vertical,15)
        .padding(.trailing,30)
            .overlay(!self.last ? AnyView(Underline()) : AnyView(Text("")),alignment: .bottomTrailing)
            .padding(.leading,30)
    }
    func changeDateFormat(date:Date)->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yy"
        let res = dateFormatter.string(from: date)
        return "\(String(describing: res))"
    }
}

enum SocialMediaType{
    case youtube
    case facebook
    case line
    case whatsapp
    case discord
    case instagram
}

struct ProfileSocialMediaDisplay: View {
    var socialMedia: SocialMediaType
    var username:String
    var body: some View {
        HStack(alignment: .center, spacing: 0){
            Image(getSocialMediaLogo(socialMedia))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(.trailing,10)
            if username != "" {
                ContentText(content: "\(username)", size: .big)
            } else {
                ContentText(content: " - ", size: .big)
            }
            
        }.frame(width: screen.width/5*2, height: 40, alignment: .leading)
    }
    func getSocialMediaLogo(_ sosmed:SocialMediaType)->String{
        switch sosmed {
        case .discord:
            return "discordLGS"
        case .facebook:
            return "facebookLGS"
        case .line:
            return "lineLGS"
        case .whatsapp:
            return "waLGS"
        case .youtube:
            return "youtubeLGS"
        case .instagram:
            return "instagramLGS"
        }
    }
}

struct SocialMediaShow: View {
    var author:AuthorModel
    var body: some View {
        VStack(alignment:.center, spacing: 0){
            self.renderSosmed(sos: self.getDicSos(author: self.author))
        }
    }
    func getDicSos(author:AuthorModel)->[[SocialMediaType:String]] {
        var sosmed:[[SocialMediaType:String]] = []
        if author.youtube != "" {
            sosmed.append([.youtube:author.youtube])
        }
        if author.line != "" {
            sosmed.append([.line:author.line])
        }
        if author.facebook != "" {
            sosmed.append([.facebook:author.facebook])
        }
        if author.whatsapp != "" {
            sosmed.append([.whatsapp:author.whatsapp])
        }
        if author.instagram != "" {
            sosmed.append([.instagram:author.instagram])
        }
        if author.discord != "" {
            sosmed.append([.discord:author.discord])
        }
        return sosmed
    }
    func renderSosmed(sos:[[SocialMediaType:String]])->AnyView {
        if sos.count == 0 {
            return AnyView(
                NoSosMed()
            )
        } else if sos.count == 1 {
            return AnyView(
                HStack(alignment: .center, spacing: 10){
                    ProfileSocialMediaDisplay(socialMedia: self.getKeyFromDic(dic: sos[0]), username: self.getValueFromDic(dic: sos[0]))
                }.padding(.leading,35)
                    .padding(.bottom,40)
                    .padding(.top,25)
            )
        }
        var view:[AnyView] = []
        let indexes = Int(round(Double(sos.count/2)))
        for i in 1...indexes {
            print(i*2-1)
            view.append(AnyView(
                HStack(alignment: .center, spacing: 10){
                    ProfileSocialMediaDisplay(socialMedia: self.getKeyFromDic(dic: sos[i*2-2]), username: self.getValueFromDic(dic: sos[i*2-2]))
                    if sos.count >= i*2{
                        ProfileSocialMediaDisplay(socialMedia: self.getKeyFromDic(dic: sos[i*2-1]), username: self.getValueFromDic(dic: sos[i*2-1]))
                    }
                }.padding(.leading,35)
                    .padding(.bottom,40)
                    .padding(.top,25)
            ))
        }
        return AnyView(
            VStack(alignment: .leading, spacing: 0){
                view[0]
                if view.count-1 >= 1 {
                    view[1]
                }
                if view.count-1 >= 2 {
                    view[2]
                }
            }
        )
    }
    func getKeyFromDic(dic:[SocialMediaType:String])->SocialMediaType {
        for (key, _) in dic {
            return key
        }
        return .discord
    }
    func getValueFromDic(dic:[SocialMediaType:String])->String {
        for (_, value) in dic {
            return value
        }
        return ""
    }
}

struct NoSosMed: View {
    var body: some View{
        VStack(alignment: .center){
            Image("noSosMed")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:178,height:197)
            Text("No known social media :(")
                .font(.system(size: 27, weight: .semibold, design: .default))
                .opacity(0.5)
                .padding(.top,20)
                .padding(.bottom,10)
            Text("Sorry, there are no known social media of Real Brad. In the meantime, you can explore Real Brad’s modules :)")
                .multilineTextAlignment(.center)
                .font(.system(size: 14, weight: .regular, design: .default)).opacity(0.5)
        }.frame(width:screen.width)
            .padding(.top,20)
        .scaleEffect(0.9)
    }
}

extension Dictionary where Value: Equatable {
    func someKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}

