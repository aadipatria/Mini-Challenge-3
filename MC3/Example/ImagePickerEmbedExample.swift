//
//  ImagePickerEmbedExample.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ImagePickerEmbedExample: View {
    @State var image:Image? = Image("RealBrad")
    var body: some View {
        VStack(spacing:15){
            image!
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:100,height:100)
                .clipShape(Circle())
            ImagePickerEmbed(imageBinding: $image) {
                Text("click to change profile")
            }
        }
    }
}

struct ImagePickerEmbedExample_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerEmbedExample()
    }
}
