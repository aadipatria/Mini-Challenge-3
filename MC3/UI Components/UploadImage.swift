//
//  UploadImageButton.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 06/08/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct UploadImageButton: View {
    //@Binding var image: Image?
    
    var body: some View {
        //ImagePickerEmbed(imageBinding: $image) {
            HStack(spacing: 0) {
                Image("UploadImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:19, height: 15, alignment: .center)
                    .padding(.leading, 25)
                
                Text("Image")
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .padding(.horizontal, 14)
            }
            .frame(idealWidth: UIScreen.main.bounds.width - 60, maxWidth: UIScreen.main.bounds.width - 60, minHeight: 44, maxHeight: 44, alignment: .leading)
            .background(Color(red: 209/255, green: 209/255, blue: 209/255))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 1))
        }
    //}
}

struct UploadImage_Preview: PreviewProvider {
    static var previews: some View {
        UploadImageButton()
    }
}
