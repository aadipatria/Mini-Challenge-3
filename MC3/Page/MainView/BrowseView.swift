//
//  BrowseView.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 27/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct BrowseView: View {
    @ObservedObject var dataCenter:DataCenter = DataCenter.getInstance()
    @State var isLogin:Bool = false
    @Binding var tabBarVisible:Bool
    @State var isSearchView:Bool = false
    @State var isBrowseByGenre:Bool = false
    @State var browseGenre:Genre = .action
    @State var isRecentView:Bool = false
    @State var isModuleProfileView:Bool = false
    @State var selectedAuthor:AuthorModel = AuthorStub.getPlainUser()
    @State var isAlert = false
    @State var isMyProfileView:Bool = false
    @State var author:String = ""
    @State var searchInput:String = ""
    @State var previewModule:Bool = false
    var body: some View {
        ZStack{
            BrowseBase(onTapProfile:{
                if (self.dataCenter.getActiveUser() != nil) {
                    self.isMyProfileView.toggle()
                } else {
                    self.isLogin.toggle()
                }
                
            },title: "Browse", profile: "people") {
                ScrollView(.vertical){
                    Button(action: {
                        self.isSearchView.toggle()
                    }){
                        searchBar(inputBinding: $searchInput)
                    }.buttonStyle(PlainButtonStyle())
                    GenreSection(isBrowseByGenre: $isBrowseByGenre,
                                 genre: $browseGenre)
                        .padding(.bottom, 10)
                    RecentSection(modules: self.dataCenter.getAllModules(),isLogin: $isAlert,isPreview: $previewModule)
                    PopularSection(authors: self.dataCenter.getAllAuthors(), selected: $selectedAuthor, changePage: $isModuleProfileView)
                    Spacer().padding(.bottom,100)
                }
            }.alert(isPresented: $isAlert) {
                Alert(title: Text("Login Required"), message: Text("Sign Up or Login to Saved Module"),
                      primaryButton: .default(Text("Sign In"), action: {
                        self.isLogin = true
                      }),
                      secondaryButton: .default(Text("Cancel")))
            }.zIndex(1)
            .onAppear{
                print(self.isLogin)
            }
            if isSearchView {
                SearchModuleView(isActive: $isSearchView)
                .modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
                
            }
            else if isBrowseByGenre {
                BrowseByGenre(isActive: $isBrowseByGenre, genre: browseGenre )
                    .modifier(PageTransitionModifier())
                    .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
            else if isModuleProfileView {
                ProfileCardPage(author: self.selectedAuthor, isActive: $isModuleProfileView)
                .modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
            else if isRecentView {
                // later recent view
            }
            else if previewModule {
                ModuleMain(isActive: $previewModule)
                .zIndex(3).modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
            
            else if isLogin {
                LoginPage(isActive: $isLogin, dataCenter: self.dataCenter)
                    .modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
            else if isMyProfileView{
                ProfilePage(isActive: $isMyProfileView)
                 .modifier(PageTransitionModifier())
                .modifier(TabBarHandler(tabBarVisible: self.$tabBarVisible))
            }
        }
    }
}

struct TabBarHandler: ViewModifier {
    @Binding var tabBarVisible:Bool
    func body(content: Content) -> some View {
        return content
            .onAppear{
                self.tabBarVisible = false
            }.onDisappear{
                self.tabBarVisible = true
            }
    }
}


struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView( isLogin: false, tabBarVisible: .constant(true))
    }
}




struct RecentSection: View {
    var modules:[ModuleModel]
    @Binding var isLogin:Bool
    @Binding var isPreview:Bool
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            ContentText(content: "Recent", size: .semiTitle).padding(.horizontal,30).padding(.bottom,10)
            RecentCarousel(modules: modules,isLogin: $isLogin, isPreview: $isPreview)
        }
    }
}

struct PopularSection: View {
    var authors:[AuthorModel]
    @Binding var selected:AuthorModel
    @Binding var changePage:Bool
    var body: some View {
        VStack(alignment: .leading, spacing:0){
            ContentText(content: "Popular", size: .semiTitle).padding(.horizontal,30).padding(.vertical,10)
            PopularCarousel(authors: authors, selected: $selected, changePage: $changePage)
        }
    }
}
