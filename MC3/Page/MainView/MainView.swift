//
//  MainView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 27/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

enum TabBarChoice {
    case browse
    case saved
    case mymodule
}

struct MainView: View {
    @State var choice:TabBarChoice = .browse
    @State var tabBarVisible:Bool = true
    @ObservedObject var dataCenter = DataCenter.getInstance()
    @State var activeUser:AuthorModel? = nil
    var body: some View {
        ZStack(alignment: .bottom){
            if choice == .browse{
                BrowseView(tabBarVisible: $tabBarVisible)
                    .zIndex(1)
            } else if choice == .saved{
                SavedModuleView(tabBarVisible: $tabBarVisible)
                    .zIndex(1)
            } else if choice == .mymodule{
                MyModuleView(tabBarVisible: $tabBarVisible)
                    .zIndex(1)
            }
            
            if tabBarVisible {
                HStack(spacing:0){
                    TabBarIcon(action: { self.choice = .browse }, isActive: choice == .browse, iconName: "globe", content: "Browse")
                    TabBarIcon(action: {
                        self.choice = .mymodule
                    }, isActive: choice == .mymodule, iconName: "book", content: "MyModule")
                    TabBarIcon(action: {
                        self.choice = .saved
                    }, isActive: choice == .saved, iconName: "bookmark", content: "Saved Module")
                }.zIndex(2)
                .frame(width:screen.width - 60,height:54,alignment: .center)
                .background(Color.white)
                    .cornerRadius(20)
                .padding(.bottom,20)
                .transition(.move(edge: .bottom))
                .animation(.easeInOut(duration: 0.1))
            }
        }.edgesIgnoringSafeArea(.bottom)
            .preferredColorScheme(.light)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct TabBarIcon: View {
    var action:()->Void
    var isActive:Bool
    var iconName:String
    var content:String
    
    var body: some View {
        VStack(spacing:5){
            Image(systemName: iconName)
                .font(.system(size: 24, weight: .regular, design: .rounded))
            Text(content).font(.system(size: 12, weight: .regular, design: .rounded))
        }
        .frame(width: (screen.width-60)/3, height:54,alignment: .center)
        .background(isActive ? Color.nightSky.frame(height: 54) : Color.white.frame(height: 54))
        .foregroundColor( isActive ? .gold : .black)
        .onTapGesture {
            self.action()
        }
    }
}
