//
//  searchBar.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 29/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct searchBar: View {
    @Binding var inputBinding:String
    var withCancel:Bool = false
    var cancelFunction:(()->Void)? = nil
    var disabled:Bool = true
    var body: some View {
        HStack(alignment: .center, spacing: 20){
            HStack(spacing:0){
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray).padding(.trailing,10)
                TextField("Search Modules", text: self.$inputBinding)
                    .disabled(!withCancel && disabled)
                if inputBinding.count > 0 {
                    Button(action: {self.inputBinding = ""}){
                        Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                    }.buttonStyle(PlainButtonStyle())
                    
                }
            }.padding(.vertical,7)
            .padding(.horizontal,14)
            .background(Color.searchBar)
            .cornerRadius(10)
            if withCancel{
                Button(action: {
                    if let cancel = self.cancelFunction {
                        cancel()
                    }
                }){
                    Text("Cancel")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(.red)
                }.buttonStyle(PlainButtonStyle())
            }
        }.padding(.top,15)
        .padding(.horizontal,25)
        
    }
}

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        searchBar(inputBinding: .constant("testing"))
    }
}
