//
//  ImagePickerEmbedExample.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ImagePickerEmbedExample: View {
    @State var image:URL? = URL(fileURLWithPath: Bundle.main.path(forResource: "RealBrad", ofType: "png")!)
    var body: some View {
        VStack(spacing:15){
            //placeholder 
            //Image(uiImage: UIImage(data: NSData(contentsOf: image!) as Data)!)
            Image("RealBrad")
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
