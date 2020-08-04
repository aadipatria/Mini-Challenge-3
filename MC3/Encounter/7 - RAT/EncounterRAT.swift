//
//  EncounterRAT.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 30/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct EncounterRAT: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var listRAT: [ReadAloudText]
    
    var body: some View {
        VStack {
            if listRAT.isEmpty {
                EncounterRATEdit(editMode: .add)
            } else {
                EncounterRATList()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct EncounterRAT_Preview: PreviewProvider {
    static var previews: some View {
        EncounterRAT(listRAT: []).environmentObject(ModuleInfo())
    }
}
