//
//  ApplicationActionButton.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 23/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct ApplicationActionButton: View {
    var content:String
    var paddingVertical:CGFloat = 10
    var enableFunction:()->Bool
    var action:()->Void
    var body: some View {
        Button(action: {
            if self.enableFunction() {
                self.action()
            }
        }){
        ContentText(content: "\(content)", size: .normal)
            .frame(width: screen.width * (4/5))
            .padding(.vertical, 10)
            .foregroundColor(!enableFunction() ? Color.white : Color.black)
            .background(!enableFunction() ? Color.init(red: 196/255, green: 196/255, blue:196/255 ) : Color.init(red: 244/255, green: 211/255, blue:123/255 ))
            .cornerRadius(10)
            .padding(.vertical, paddingVertical)
        }
    }
}

struct ApplicationActionButton_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ApplicationActionButton(content: "disabled", enableFunction: {return false}, action: {})
            ApplicationActionButton(content: "able", enableFunction: {return true}, action: {})
        }
    }
}
