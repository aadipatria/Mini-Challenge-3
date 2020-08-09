//
//  ModuleHeader.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleHeader: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    
    @State var name: String = ""
    @State var author: String = ""
    @State var image: String = "RealBrad"
    var action: () -> ()
    
    var body: some View {
        VStack(spacing:0){
            Rectangle().frame(height: 44)
            .foregroundColor(.black)
            HStack(spacing: 0) {
                ModuleBackButton(action: action)
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text(name)
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    Text(author)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(minWidth: 200, alignment: .trailing)
                .padding(.trailing, 20)
                
                Button(action: {
                    // profile page
                }){
                    Image("people")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60, alignment: .center)
                    .clipShape(Circle())
                        
                }
            }
            .frame(height: 100)
            .padding(.horizontal, 30)
            .background(Color.black)
            
            .onAppear(perform: {
                self.name = self.moduleInfo.currentModule.name
                self.author = self.moduleInfo.currentModule.author.name
                self.image = self.moduleInfo.currentModule.author.profileImage
            })
        }
    }
}

struct ModuleBackButton: View {
    var action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.left")
                .foregroundColor(.white)
                .font(.system(size: 19, weight: .semibold))
        }
        .frame(minWidth: 30, minHeight: 50, alignment: .leading)
    }
}

struct ModuleSegmentHeader: View {
    var title: String
    var action: () -> ()
    var isEditable: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                Spacer()
                
                if isEditable {
                    AddButton(action: action)
                }
            }
            .frame(height: 30)
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
            
            Rectangle()
                .fill(Color.clear)
                .frame(width: UIScreen.main.bounds.width, height: 2)
        }
    }
}

struct ModuleHeader_Previews: PreviewProvider {
    static var previews: some View {
        ModuleHeader(action: {}).environmentObject(ModuleInfo())
//        ModuleSegmentHeader(title: "Encounter", action: {})
    }
}
