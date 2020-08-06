//
//  SocialMediaPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 24/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct SocialMediaPage: View {
    @Binding var isActive:Bool
    @Binding var user:AuthorModel
    @ObservedObject var dataCenter = DataCenter()
    var body: some View {
        NavigationModalTemplate(title: "Social Media", backButtonFunc: {
            self.isActive.toggle()
        }){
            ScrollView(.vertical){
                VStack(alignment: .center, spacing: 0){
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Youtube", input: $user.youtube, logoName: "youtubeLGS")
                    }.padding(.bottom,20)
                        .padding(.top,15)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Facebook", input: $user.facebook, logoName: "facebookLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Instagram", input: $user.instagram, logoName: "instagramLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20,paddingTopSize: 0){
                        InputSocialMedia(heading: "Whatsapp", input: $user.whatsapp, logoName: "waLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20, paddingTopSize: 0){
                        InputSocialMedia(heading: "Line", input: $user.line, logoName: "lineLGS")
                    }.padding(.bottom,20)
                    ProfileSection(paddingBottomSize: 20,paddingTopSize: 0){
                        InputSocialMedia(heading: "Discord", input: $user.discord, logoName: "discordLGS")
                    }.padding(.bottom,20)
                    ApplicationActionButton(content: "Save",
                        paddingVertical: 0,
                        enableFunction: {return true},
                        action: {
                        // save action
                            self.dataCenter.saveUser(user: self.user)
                            self.isActive = false
                    })
                }
            }
        }
    }
}

struct InputSocialMedia: View {
    var placeholder:String = ""
    var heading:String
    @Binding var input:String
    var logoName:String
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            ContentText(content: "\(heading)", size: .big)
            HStack(alignment: .center){
                Image(logoName)
                    .resizable()
                    .frame(width: 13, height: 13)
                Underline().frame(height: 13)
                TextField("\(placeholder)", text: $input)
                    .font(.system(size: 13))
                if input.count > 0 {
                    Button(action: {
                        self.input = ""
                    }){
                        Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray)
                        .font(.system(size: 15))
                    }
                }
            }.padding(.vertical, 10)
            .overlay(Underline(),alignment: .bottom)
        }.padding(.horizontal, 10)
    }
}

struct SocialMediaPage_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaPage(isActive: .constant(true), user: .constant(AuthorStub.getActiveUser()))
    }
}
