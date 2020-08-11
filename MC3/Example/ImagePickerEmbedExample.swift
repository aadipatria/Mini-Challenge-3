//
//  ImagePickerEmbedExample.swift
//  MC3
//
//  Created by Peter Andrew on 04/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct ImagePickerEmbedExample: View {
    @State var image:URL? = nil
    var body: some View {
        VStack(spacing:15){
            if image != nil {
                
                
            }
            
            ImagePickerEmbed(imageBinding: $image) {
                Text("click to change profile")
            }
        }
    }
    func getImage(url:URL) -> Image {
        if let data = try? Data(contentsOf: url)
        {
          return Image(uiImage: UIImage(data: data)!
//          .resizable()
//          .aspectRatio(contentMode: .fill)
//          .frame(width:100,height:100)
//          .clipShape(Circle())
            )
        }
        return Image("people")
    }
}

struct ImagePickerEmbedExample_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerEmbedExample()
    }
}
