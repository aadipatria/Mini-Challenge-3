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
    
    @State var isSearchView:Bool = false
    @State var modules:[ModuleModel] = ModulesStub.getModules()
    @State var searchInput:String = ""
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
                ModuleListScroll(modules: modules)
            }.zIndex(1)
            if isSearchView {
                SearchModuleView(isActive: $isSearchView)
                .modifier(PageTransitionModifier())
            }
        }
    }
}

struct BrowseByGenre_Previews: PreviewProvider {
    static var previews: some View {
        BrowseByGenre(isActive: .constant(true), genre: .horror)
    }
}

