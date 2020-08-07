//
//  DropdownPicker.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//
// usage tutorial can be found at Example/DropdownPickerExample

import SwiftUI

struct DropdownPicker: View {
    @Binding var showPicker:Bool
    @Binding var selectedIndexBinding:Int?
    var pickerSize:CGFloat = UIScreen.main.bounds.width
    var array:[String]
    @State private var currIndex:Int = 0
    var body: some View {
        VStack(alignment: .center, spacing: 0){
            if showPicker {
                VStack(alignment: .leading, spacing: 0){
                    Divider()
                        .frame(height:3)
                        .background(Color.init(red: 238/255, green: 238/255, blue: 238/255))
                    Button( action: {
                        self.selectedIndexBinding = self.currIndex
                        self.showPicker = false
                    }){
                        Text("Done").font(.system(size: 17, weight: .semibold, design: .rounded))
                    }.padding(.horizontal,25)
                    .padding(.vertical,10)
//                    Divider().background(Color.black)
                    Picker(selection: $currIndex, label:Text("Armor Picker")){
                        ForEach(array.indices){ index in
                            Text(self.array[index]).tag(index)
                        }
                    }.frame(width:pickerSize)
                    .background(Color.init(red: 238/255, green: 238/255, blue: 238/255))
                     .labelsHidden()
                }
                    
               
            }
        }.transition(.scale)
        .animation(.easeIn)
    }
}

struct DropdownPicker_Previews: PreviewProvider {
    static var previews: some View {
        DropdownPicker(showPicker: .constant(true), selectedIndexBinding: .constant(1), array: ["dar","Kop","then"])
    }
}
