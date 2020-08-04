//
//  ModuleHeader.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleHeader: View {
    var module: String
    var author: String
    var image: String
    var action: () -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            ModuleBackButton(action: action)
            Spacer()
            
            VStack(alignment: .trailing, spacing: 5) {
                Text(module)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text(author)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(minWidth: 200, alignment: .trailing)
            .padding(.trailing, 20)
            
            Button(action: {print("none")}){
                Image(image)
                    .renderingMode(.original)
            }
        }
        //.frame(width: UIScreen.main.bounds.width, height: 100)
        .frame(height: 100)
        .padding(.horizontal, 30)
        .background(Color.black)
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

struct ModuleHeader_Previews: PreviewProvider {
    static var previews: some View {
        ModuleHeader(module: "Legacy of Blood", author: "Real Brad", image: "RealBrad", action: {})
    }
}
