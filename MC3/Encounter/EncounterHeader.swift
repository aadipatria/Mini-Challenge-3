//
//  EncounterHeader.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterHeader: View {
    @EnvironmentObject var moduleInfo: ModuleInfo
    @ObservedObject var dataCenter = DataCenter()
    
    var section: EncounterSection
    var isEditable: Bool
    var action: () -> Void = {}
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Text(EncounterSectionDescription.desc[section]?[0] ?? "Title")
                    .font(.system(size: 21, weight: .medium, design: .rounded))
                
                Spacer()
                VStack {
                    if dataCenter.getAllAuthors()[4].name == moduleInfo.currentModule.author.name {
                        if isEditable {
                            AddButton(action: action)
                        } else {
                            EmptyView()
                        }
                    }
                }
                
            }
            //.frame(width: UIScreen.main.bounds.width, height: 21, alignment: .leading)
            .padding(.top, 30)
            .padding(.bottom, 9)
            .padding(.horizontal, 40)
            
            Text(EncounterSectionDescription.desc[section]?[2] ?? "Desc")
                .font(.system(size: 13, weight: .regular, design: .rounded))
                //.padding(.bottom, 30)
                .padding(.leading, 40)
                .padding(.trailing, 90)
            
            Spacer()
        }
        //.frame(width: UIScreen.main.bounds.width, height: 134)
        .frame(height: 134)
    }
}

struct EncounterHeader_Preview: PreviewProvider {
    static var previews: some View {
        //EncounterHeader(title: "Title", description: "description that is supposed to be very long but not the real thing so we're not sure how long it is supposed to be therefore we just continue just to test the main capability of what this text area can display within the allocated space")
        EncounterHeader(section: .ReadAloudText, isEditable: true, action: {}).environmentObject(ModuleInfo())
    }
}
