//
//  ProfilePicture.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 22/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

enum PicSize {
    case small
    case normal
}

struct ProfilePicture:View {
    let name:String
    let purpose:PicSize
    var body: some View{
        Image(name)
        .resizable()
        .aspectRatio(contentMode: .fill)
            .frame(width: self.purpose == PicSize.normal ? 100 : 66, height: self.purpose == PicSize.normal ? 100 : 66)
        .clipShape(Circle())
    }
}

struct ProfilePicture_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ProfilePicture(name: "people", purpose: .normal)
            ProfilePicture(name: "people", purpose: .small)
        }
    }
}
