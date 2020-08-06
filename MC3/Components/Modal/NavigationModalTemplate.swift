//
//  ModalTemplateView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct NavigationModalTemplate<Content: View>:View {
    var backButtonFunc:(()->Void)?
    var withHeading:Bool
    var title:String
    let content: Content
    var modalColor:Color 
    
    init(title:String, modalColor:Color? = nil, heading:Bool = true, backButtonFunc:(()->Void)? = nil, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.backButtonFunc = backButtonFunc
        self.title = title
        self.withHeading = heading
        if let color = modalColor {
            self.modalColor = color
        } else {
            self.modalColor = Color.init(red: 244/255, green: 244/255, blue: 244/255)
        }
    }
    var body: some View{
        ZStack{
            Color.init(red: 20/255, green: 22/255, blue: 32/255)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(spacing:0){
                if withHeading{
                    ModalHeading(clickFunc: {
                        if let function = self.backButtonFunc {
                            function()
                        }
                    }, title: "\(title)")
                    .frame(width: screen.width)
                } else {
                    Spacer().frame(width: screen.width, height: 26)
                }
                ZStack(alignment: .top){
                    ModalCard(color: modalColor)
                    VStack(spacing: 0){
                        self.content
                    }  
                }
            }
        }
    }
}

struct NavigationModalTemplate_Previews: PreviewProvider {
    static var previews: some View {
        NavigationModalTemplate(title:"Testing"){
            Text("Testing")
        }
    }
}
