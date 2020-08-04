//
//  ContentView.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 28/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ModuleSegment: View {
    @State var moduleSegmentIndex = 0
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
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    EncounterCard()
                    EncounterCard()
                    EncounterCard()
                }
            }
        }
    }
}

struct ModuleHeader: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 100)
            
            HStack(spacing: 20) {
                Button(action: {
                    print("nothing")
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .semibold))
                }
                    .padding(.leading, 30)
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text("Legacy of Blood")
                        .font(.system(size: 24, weight: .semibold))
                        .foregroundColor(.white)
                    Text("Real Brad")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Image("RealBrad")
                    .padding(.trailing, 30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ModuleSegment()
        //ModuleHeader()
        //EncounterCard()
    }
}
