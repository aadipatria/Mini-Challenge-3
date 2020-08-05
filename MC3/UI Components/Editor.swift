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
        .frame(idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
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

struct NumberField: View {
    var description: String
    var image: String
    @Binding var inputText: Int
    
    let fieldHeight: CGFloat = 44
    
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(maxWidth: 64, minHeight: fieldHeight, maxHeight: fieldHeight)
                
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 15, alignment: .center)
                    .padding(.horizontal, 5)
            }
            
            Rectangle()
                .fill(Color.black)
                .frame(width: 1, height: fieldHeight)
            
            TextField(description, value: $inputText, formatter: NumberFormatter())
                .font(.system(size: 13, weight: .regular, design: .rounded))
                .padding(.horizontal, 14)
        }
        .background(Color.white)
        .frame(idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: fieldHeight, maxHeight: fieldHeight)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 1))
        //.padding(.horizontal, 30)
    }
}


struct MultiLineField: View {
    var description: String
    var height: CGFloat = 104
    @Binding var inputText: String
    
    var body: some View {
        HStack(spacing: 0) {
            VStack {
                MultilineTextField(description, text: $inputText)
            }
            .font(.system(size: 13, weight: .regular, design: .rounded))
            .padding(.leading, 25)
            .padding(.trailing, 14)
            
            getButton()
        }
        .background(Color.white)
        .frame(minWidth: 300, idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: height, maxHeight: height)
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

enum EditMode {
    case add
    case edit
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//struct EditorPreview: PreviewProvider {
//    static var previews: some View {
//        //CancelButton(actionCancel: {})
//        //SingleLineField(description: "", image: "TextfieldRAT")
//        MultiLineField(description: "Description")
//    }
//}
