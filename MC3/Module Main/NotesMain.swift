//
//  NotesMain.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct NotesMain: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ModuleSegmentHeader(
                title: "Notes",
                action: {})
            
            VStack(spacing: 0) {
                ForEach(0..<3) {_ in 
                    ContentCard(
                        title: "Notes Title",
                        description: "Notes Description",
                        actionDelete: {},
                        actionEdit: {}
                    )
                }
            }
        }
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        NotesMain()
    }
}
