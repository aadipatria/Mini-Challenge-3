//
//  DropdownPickerExample.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DropdownPickerExample: View {
    @State var showPicker = false
    @State var tes:String = ""
    var dropdownOption = ["Helmet","chainmail","shield","animal_Skin"]
    @State var selectedIndex:Int? = nil
    var body: some View {
        VStack(alignment: .trailing, spacing: 30) {
            Button("Tap to show dropdown"){
                self.showPicker = true
            }
            DropdownPicker(showPicker: $showPicker, selectedIndexBinding: $selectedIndex, array: dropdownOption)
            TextField("test", text: $tes)
        }
    }
}

struct DropdownPickerExample_Previews: PreviewProvider {
    static var previews: some View {
        DropdownPickerExample()
    }
}
