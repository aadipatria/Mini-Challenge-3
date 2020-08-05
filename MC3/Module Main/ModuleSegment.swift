//
//  ContentView.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 28/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleSegment: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @State var showPicker = false
    var option = ["honda","suzuki","yamaha"]
    @State var selectedIndex:Int? = nil
    @State var moduleSegmentIndex = 1
    @State var moduleSegment = ["Overview", "Encounters", "Screen", "Notes"]
    
    var body: some View {
        VStack(spacing: 0) {
            Picker(selection: $moduleSegmentIndex, label: Rectangle()) {
                ForEach(0..<moduleSegment.count) { index in
                    Text(self.moduleSegment[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.all, 30)
            
            HStack {
                Text(moduleSegment[moduleSegmentIndex])
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                Spacer()
                Button(action: {
                    print("nothing")
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                        .font(.system(size: 21, weight: .heavy, design: .rounded))
                }
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 30)
            Rectangle()
                .fill(Color.separator)
                .frame(width: UIScreen.main.bounds.width, height: 2)
            
            getMainContent(index: moduleSegmentIndex)
        }
    }
    
    func getMainContent(index: Int) -> AnyView {
        switch index {
        case 0:
            return AnyView(OverviewMain())
        case 1:
            return AnyView(EncounterMain())
        case 3:
            return AnyView(NotesMain())
        default:
            return AnyView(EncounterMain())
        }
    }
}

struct ModuleSegment_Previews: PreviewProvider {
    static var previews: some View {
        ModuleSegment().environmentObject(ModuleInfo())
    }
}
