//
//  ChangePasswordPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 23/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ChangePasswordPage: View {
    @Binding var isActive:Bool
    @ObservedObject var dataCenter:DataCenter = DataCenter.getInstance()
    @Binding var user:AuthorModel
    @State var oldPass:String = ""
    @State var newPass:String = ""
    @State var confirmPass:String = ""
    @State var visibleOldPass:Bool = true
    @State var visibleNewPass:Bool = true
    @State var visibleConfirmPass:Bool = true
    var body: some View {
        NavigationModalTemplate(title: "Change Password", backButtonFunc: {
            self.isActive.toggle()
        }){
            ChangePasswordRow{
                TitleText(content: "Enter old password",type: .h3)
                PasswordField(input: $oldPass, isHidden: $visibleOldPass)
                Text("Enter your old / current password, not the password from other application (google/facebook)")
                    .font(.system(size: 11, weight: .light, design: .rounded))
                Button(action: {}){
                    ContentText(content: "Forgot your password?", size: .normal)
                        .padding(.top, 10)
                }
            }.padding(.top, 40)
                .padding(.bottom, 20)
            ChangePasswordRow{
                TitleText(content: "Enter new password",type: .h3)
                PasswordField(input: $newPass, isHidden: $visibleNewPass)
                Text("Minimum 8 character")
                    .font(.system(size: 11, weight: .light, design: .rounded)).padding(.bottom)
                TitleText(content: "Confirm new password",type: .h3).padding(.bottom, 4)
                PasswordField(input: $confirmPass, isHidden: $visibleConfirmPass)
            }.padding(.bottom, 40)
            ApplicationActionButton(content: "Save", enableFunction:{
                return self.oldPass.count >= 8 &&
                    self.oldPass == self.user.password &&
                    self.newPass.count >= 8 &&
                    self.confirmPass == self.newPass
            }, action: {
                self.user.password = self.newPass
                self.dataCenter.saveUser(user: self.user)
                self.isActive.toggle()
            })
        }
    }
}

struct ChangePasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordPage(isActive: .constant(true), user: .constant(AuthorStub.getPlainUser()))
    }
}

struct PasswordField: View {
    var padding:CGFloat = 10
    @Binding var input:String
    @Binding var isHidden:Bool
    var body: some View {
        HStack(alignment: .center){
            changeState(isHidden: isHidden)
            Button(action: {
                self.isHidden = !self.isHidden
            }){
                Image(systemName: isHidden ? "eye.slash.fill" : "eye.fill")
                .foregroundColor(Color.gray)
                .font(.system(size: 13))
            }
        }.padding(.vertical, padding)
        .overlay(Underline(),alignment: .bottom)
    }
    func changeState(isHidden:Bool)->AnyView{
        if isHidden{
            return AnyView(
                SecureField("\(input)", text: $input)
                .font(.system(size: 13))
            )
        }
        return AnyView(
            TextField("\(input)", text: $input)
            .font(.system(size: 13))
        )
    }
}

struct ChangePasswordRow<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        VStack(alignment: .leading){
            self.content
        }.padding(.vertical, 25)
            .padding(.horizontal, 30)
            .background(Color.white)
            .cornerRadius(10)
    }
}
