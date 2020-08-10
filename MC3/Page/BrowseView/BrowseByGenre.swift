//
//  BrowseByGenre.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct BrowseByGenre: View {
    @Binding var isActive:Bool
    var genre:Genre
    @ObservedObject var dataCenter = DataCenter.getInstance()
    @State var isSearchView:Bool = false
    @State var isLogin = false
    @State var isPreview = false
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    @State var searchInput:String = ""
    @State var isAlert = false
    var body: some View {
        ZStack{
            NavigationModalTemplate(title: "\(genre)".capitalized, modalColor: .calmBlue, backButtonFunc: {
                self.isActive = false
            }){
                Button(action: {
                    self.isSearchView.toggle()
                }){
                    searchBar(inputBinding: $searchInput)
                }.buttonStyle(PlainButtonStyle())
                ModuleListScroll(modules: filterModule(genre: self.genre, modules: modules), isPreview: $isPreview, dataCenter: dataCenter, isLogin: $isAlert)
            }.alert(isPresented: $isAlert) {
                Alert(title: Text("Login Required"), message: Text("Sign Up or Login to Save Module"),
                      primaryButton: .default(Text("Sign In"), action: {
                        self.isLogin = true
                      }),
                      secondaryButton: .default(Text("Cancel")))
            }.zIndex(1)
            if isSearchView {
                SearchModuleView(isActive: $isSearchView, modules: self.filterModule(genre: self.genre, modules: modules))
                .modifier(PageTransitionModifier())
            }
            if isLogin {
                LoginPage(isActive: self.$isLogin, dataCenter: self.dataCenter).zIndex(2)
            }
            if isPreview {
                ModuleMain(isActive: $isPreview)
                .zIndex(3)
            }
        }
    }
    func filterModule(genre:Genre, modules:[ModuleModel])->[ModuleModel]{
        return modules.filter{ module in
            return module.genre == genre
        }
    }
}

struct BrowseByGenre_Previews: PreviewProvider {
    static var previews: some View {
        BrowseByGenre(isActive: .constant(true), genre: .horror)
    }
}

