//
//  FeedBackPage.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct FeedBackPage: View {
    @State var feedback:String = ""
    @Binding var isActive:Bool
    var body: some View {
        NavigationModalTemplate(title: "Feedback", backButtonFunc: {
            self.isActive.toggle()
        }){
            ProfileSection(){
                TitleText(content: "Do you have any suggestions to make our app better?", type: .h3)
                    .frame(width: screen.width-60)
                InputWithUnderline(placeholder: "Placeholder", input: $feedback)
                    .padding(.vertical, 20)
            }.cornerRadius(10)
            .padding(.top, 40)
            ApplicationActionButton(content: "Send", enableFunction: {self.feedback.count > 0},
            action: {print("lorem")})
        }
    }
}

struct FeedBackPage_Previews: PreviewProvider {
    static var previews: some View {
        FeedBackPage(isActive: .constant(true))
    }
}
