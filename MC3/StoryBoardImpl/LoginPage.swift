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
    @ObservedObject var dataCenter = DataCenter()
    var body: some View {
        ZStack{
            Color.nightSky.edgesIgnoringSafeArea(.all)
            LoginViewControllerUI(backFunction: {user in
                self.dataCenter.userLogin(user: user)
                self.isActive = false
            })
        }
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(isActive: .constant(true))
    }
}

struct LoginViewControllerUI:UIViewControllerRepresentable {
    var backFunction:(_ user:AuthorModel)->Void
    func makeUIViewController(context: UIViewControllerRepresentableContext<LoginViewControllerUI>) -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(identifier: "login") as loginViewController
        controller.backFunc = self.backFunction
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LoginViewControllerUI>) {
    }
    
    
}
