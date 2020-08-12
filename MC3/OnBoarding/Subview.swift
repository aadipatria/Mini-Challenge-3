//
//  Subview.swift
//  Onboarding
//
//  Created by Duvan Sanjaya on 24/07/20.
//  Copyright © 2020 Duvan Sanjaya. All rights reserved.
//

import SwiftUI

struct Subview: View {
    
    var imageString: String
    var height:CGFloat
    var body: some View {
        ZStack(alignment: .center){
            Color.init(red: 232/255, green: 239/255, blue: 249/255)
            .edgesIgnoringSafeArea(.all)
            Image(imageString)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height:height)
            .clipped()
        }
        
    }
}

struct Subview_Previews: PreviewProvider {
    static var previews: some View {
        Subview(imageString: "first", height: 193)
    }
}
