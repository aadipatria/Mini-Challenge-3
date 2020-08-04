//
//  EditorButtons.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 02/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(Color.deleteButton)
                .frame(width: 32, height: 25)
                .overlay(Image(systemName: "bin.xmark.fill")
                    .renderingMode(.original))
        }
    }
}

struct EditButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(Color.deleteButton)
                .frame(width: 32, height: 25)
                .overlay(EditSymbol())
        }
    }
}

struct NextButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.nextButton)
                Text("Next")
                    .foregroundColor(Color.black)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
            }
            .frame(minWidth: 100, idealWidth: UIScreen.main.bounds.width * 0.39, maxWidth: 300, minHeight: 34, maxHeight: 34, alignment: .center)
            .cornerRadius(10)
        }
    }
}

struct CancelButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.cancelButton)
                Text("Cancel")
                    .foregroundColor(Color.white)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
            }
            .frame(minWidth: 100, idealWidth: UIScreen.main.bounds.width * 0.39, maxWidth: 300, minHeight: 34, maxHeight: 34, alignment: .center)
            .cornerRadius(10)
        }
    }
}

struct AddButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Rectangle()
                .fill(Color.clear)
                .overlay(Image(systemName: "plus")
                    .foregroundColor(Color.black)
                    .font(.system(size: 21, weight: .heavy, design: .rounded))
                )
                .frame(width: 25, height: 25)
        }
    }
}

struct AddButtonDisabled: View {
    var body: some View {
        Image(systemName: "plus")
            .foregroundColor(Color.disabledButton)
            .font(.system(size: 21, weight: .heavy, design: .rounded))
            .frame(width: 25, height: 25)
            //.padding(.trailing, 40)
    }
}

struct EditorButtons_Preview: PreviewProvider {
    static var previews: some View {
        //CancelButton(action: {})
        DeleteButton(action: {})
    }
}
