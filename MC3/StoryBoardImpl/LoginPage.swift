//
//  LoginPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 03/08/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @Binding var isActive:Bool
    var dataCenter:DataCenter
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.nightSky.edgesIgnoringSafeArea(.all)
            LoginViewControllerUI(saveFunction: {user in
                self.dataCenter.userLogin(user: user)
                self.isActive = false
            }, backFunc: {
                self.isActive = false
            })
            BackButton(clickFunc: {
                self.isActive = false
            })
        }
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(isActive: .constant(true), dataCenter: DataCenter())
    }
}

struct LoginViewControllerUI:UIViewControllerRepresentable {
    var saveFunction:(_ user:AuthorModel)->Void
    var backFunc:()->Void
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginViewControllerUI>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "login") as loginViewController
        controller.saveFunc = self.saveFunction
        controller.backFunc = self.backFunc
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LoginViewControllerUI>) {
    }
    
    
}
