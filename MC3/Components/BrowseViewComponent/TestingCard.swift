//
//  TestingCard.swift
//  MC3ProgMe
//
//  Created by Peter Andrew on 28/07/20.
//  Copyright © 2020 Peter Andrew. All rights reserved.
//

import SwiftUI

struct TestingCard: View {
    let cardWidth = UIScreen.main.bounds.width * 6 / 7
    let cardHeight = UIScreen.main.bounds.width / 3
   
    let clipWidth = UIScreen.main.bounds.width * 5 / 8
    let clipHeight = UIScreen.main.bounds.width / 2
   
    let recentGradient = LinearGradient(gradient: Gradient(colors: [Color(red: 74/255, green: 84/255, blue: 128/255, opacity: 1), Color(red: 36/255, green: 42/255, blue: 73/255, opacity: 1)]), startPoint: .top, endPoint: .bottom)
    let rightGradient = AngularGradient(gradient: Gradient(colors:[
    Color(red: 36/255, green: 42/255, blue: 73/255, opacity: 0.1),
    Color(red: 36/255, green: 42/255, blue: 73/255, opacity: 0.4),
    Color(red: 36/255, green: 42/255, blue: 73/255, opacity: 1),
    Color(red: 36/255, green: 42/255, blue: 73/255, opacity: 1),
    Color(red: 74/255, green: 84/255, blue: 128/255, opacity: 1),
    Color(red: 74/255, green: 84/255, blue: 128/255, opacity: 1),
    Color(red: 74/255, green: 84/255, blue: 128/255, opacity: 0.4),
    Color(red: 74/255, green: 84/255, blue: 128/255, opacity: 0.1)
    ]), center: .center, startAngle: .degrees(0), endAngle: .degrees(360))
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                Rectangle()
                    .fill(recentGradient)
                    .frame(width: UIScreen.main.bounds.width*3/8, height: UIScreen.main.bounds.width/2)
                Image("people")
                //Image("OverviewSample")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    //.clipped()
                    .frame(width: clipWidth, height: clipHeight)
                    .clipShape(Rectangle())
            }
            Rectangle()
                .fill(rightGradient)
                //.foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width, height: cardHeight)
                .offset(x: cardWidth/8, y: 0) //change x as needed
            //add more text below
            Text("Sample Text")
 
        }
        .frame(width: cardWidth, height: cardHeight, alignment: .center)
        .cornerRadius(10)
    }
}

struct TestingCard_Previews: PreviewProvider {
    static var previews: some View {
        TestingCard()
    }
}
