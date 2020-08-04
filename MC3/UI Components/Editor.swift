//
//  Editor.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 29/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct SingleLineField: View {
    var description: String
    var image: String
    @Binding var inputText: String
    
    let fieldHeight: CGFloat = 44
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 64, height: fieldHeight)
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 15, alignment: .center)
                    .padding(.horizontal, 5)
            }
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 1, height: fieldHeight)
            
            TextField(description, text: $inputText)
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .padding(.horizontal, 14)
            
            getButton()
        }
        .background(Color.white)
        .frame(minWidth: 300, idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1))
        .padding(.horizontal, 30)
    }
    
    func getButton() -> AnyView {
        if inputText == "" {
            return AnyView(EmptyView())
        } else {
            return AnyView(
                Button(action: {
                    self.inputText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 12)
            )
        }
    }
}

struct MultiLineField: View {
    @State var inputText: String = ""
    var description: String
    let fieldHeight: CGFloat = 104
    
    var body: some View {
        HStack(spacing: 0) {
            MultilineTextField(description, text: $inputText)
                .padding(.leading, 25)
                .padding(.trailing, 14)
            
            getButton()
        }
        .background(Color.white)
        .frame(minWidth: 300, idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1))
        .padding(.horizontal, 30)
    }
    
    func getButton() -> AnyView {
        if inputText == "" {
            return AnyView(EmptyView())
//            return AnyView(
//                Rectangle()
//                .frame(width: 0, height: 0)
//            )
        } else {
            return AnyView(
                Button(action: {
                    self.inputText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color.gray)
                }
                .padding(.trailing, 12)
            )
        }
    }
}

enum EditMode {
    case add
    case edit
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct EditorPreview: PreviewProvider {
    static var previews: some View {
        //CancelButton(actionCancel: {})
        //SingleLineField(description: "", image: "TextfieldRAT")
        MultiLineField(description: "Description")
    }
}
