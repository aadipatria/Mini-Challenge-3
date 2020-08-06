//
//  EditProfilePage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct EditProfilePage: View {
    @ObservedObject var dataCenter:DataCenter = DataCenter.getInstance()
    @Binding var user:AuthorModel
    @Binding var isActive:Bool
    @State var disable:Bool = true
    var body: some View {
        NavigationModalTemplate(title: "Edit Profile", backButtonFunc: {
            withAnimation(.easeInOut){
                self.isActive.toggle()
            }
        }){
            EditProfilePicture()
            ProfileSection("Account Information",paddingBottomSize: 20){
                HStack(alignment: .center){
                    ContentText(content: user.username , size: .big)
                    Spacer()
                }.padding(.vertical, 10)
                    .overlay(Underline(),alignment: .bottom)
                    .padding(.horizontal, 10)
                InputWithUnderline(placeholder: "Fullname", input: $user.name)
            }.padding(.bottom, 10)
            ProfileSection("Personal Information", paddingBottomSize: 20){
                InputWithUnderline(placeholder: "Phone", input: $user.phone, iconName: "phone.fill")
                InputWithUnderline(placeholder: "Email", input: $user.email, iconName: "envelope.fill")
            }.padding(.bottom, 10)
                ApplicationActionButton(content: "Save", enableFunction: fieldValidation, action: {
                    self.dataCenter.saveUser(user: self.user)
                    self.isActive.toggle()
                }
            )
        }
    }
    func fieldValidation() -> Bool {
        return true
//            self.email.contains("@") && self.fullname.count >= 3
    } // remember to add phone regex
}


struct EditProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        EditProfilePage(user: .constant(AuthorStub.getActiveUser()), isActive: .constant(true))
    }
}

struct InputWithUnderline: View {
    var placeholder:String
    @Binding var input:String
    var iconName:String? = nil
    var body: some View {
        HStack(alignment: .center){
            iconChecker()
            TextField("\(placeholder)", text: $input)
            .font(.system(size: 15))
            if input.count > 0 {
                Button(action: {
                    self.input = ""
                }){
                    Image(systemName: "xmark.circle.fill")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20))
                }
            }
        }.padding(.vertical, 10)
            .overlay(Underline(),alignment: .bottom)
            .padding(.horizontal, 10)
    }
    func iconChecker()->AnyView {
        if let icon = iconName {
            return AnyView(Image(systemName: "\(icon)")
                .foregroundColor(Color.gray)
                .font(.system(size: 20))
                .padding(.trailing,5)
            )
        }
        return AnyView(EmptyView())
    }
}

struct EditProfilePicture: View {
    var body: some View {
        VStack(alignment: .center){
            ProfilePicture(name: "people", purpose: .normal)
                .padding(.bottom, 5)
            Button(action: {}){
                ContentText(content: "Edit Photo", size: .normal).foregroundColor(Color.black)
            }
        }.padding(.top, 30)
            .padding(.bottom, 15)
    }
}

