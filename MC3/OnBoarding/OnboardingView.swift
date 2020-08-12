//
//  OnboardingView.swift
//  Onboarding
//
//  Created by Duvan Sanjaya on 24/07/20.
//  Copyright © 2020 Duvan Sanjaya. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var viewRouter: ModuleInfo
    
    var subviews = [
        UIHostingController(rootView: Subview(imageString: "first", height: 193)),
        UIHostingController(rootView: Subview(imageString: "second", height: 193)),
        UIHostingController(rootView: Subview(imageString: "third", height: 193))
    ]
    
    var titles = ["Create","Search","Bookmark"]
    
    var captions = ["create an enganging mobile-based modules in your own way. Get creative!","search for other modules which can inspire you to create even better!","bookmark the best modules for your recommendation and reference"]
   
    
    @State var currentPageIndex = 0
    @State var buttonContent:String = "NEXT"
    
    var body: some View {
        ZStack(alignment: .top){
            Color.init(red: 232/255, green: 239/255, blue: 249/255)
            .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 0){
                PageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                    .frame(height: 193)
                    .background(Color.red)
                    .padding(.bottom, 80.0)
                VStack(alignment: .center, spacing: 0){
                    Text(titles[currentPageIndex]).font(.system(size: 23, weight: .semibold, design: .rounded)).padding(.bottom, 25.0)
                    Text(captions[currentPageIndex])
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .frame(width: 295, height: 65)
                }.padding(.bottom, 30)
                VStack(spacing: 0){
                    PageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                        .padding(.bottom, 25.0)
                    Button(action:
                        {
                            if self.currentPageIndex == 2{
                                self.viewRouter.currentPage = "homeView"
                            }
                            if self.currentPageIndex + 1 == self.subviews.count {
                                self.currentPageIndex = 0
                            }
                            else {
                                self.currentPageIndex += 1
                            }
                            self.buttonContent = self.currentPageIndex != 2 ? "NEXT" : "GET STARTED"
                        }){
                            ButtonContent(content: buttonContent)
                        }
                    Button(action:
                    {
                        self.viewRouter.currentPage = "homeView"
                    }){
                        Text("Skip")
                            .font(.system(size: 17, weight: .medium, design: .rounded))
                            .foregroundColor(Color.black)
                            .padding(.top, 25.0)
                    }
                }
            }.padding(.top, 130)
        }
    }
}

struct ButtonContent: View {
    var content:String = "NEXT"
    var body: some View{
        ZStack{
            Rectangle()
            .fill(Color.init(red: 244/255, green: 211/255, blue: 123/255))
                .padding(0.0)
                .cornerRadius(10)
            .frame(width:166 ,height:40)
            Text(content).font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundColor(Color.black)
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
