//
//  Color Presets.swift
//  MC3
//
//  Created by Aghawidya Adipatria on 29/07/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

extension Color {
    public static var backgroundCard: Color {
        return Color(UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1))
    }
    
    public static var deleteButton: Color {
        return Color(UIColor(red: 219/255, green: 219/255, blue: 219/255, alpha: 1))
    }
    
    public static var nextButton: Color {
        return Color(UIColor(red: 244/255, green: 211/255, blue: 123/255, alpha: 1))
    }
    
    public static var cancelButton: Color {
        return Color(UIColor(red: 239/255, green: 134/255, blue: 134/255, alpha: 1))
    }
    
    public static var disabledButton: Color {
        return Color(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.25))
    }
    
    public static var separator: Color {
        return Color(UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1))
    }
    
    public static var screenRed = Color.init(red: 239/255, green: 134/255, blue: 134/255)
    
    public static var screenGreen = Color.init(red: 134/255, green: 239/255, blue: 140/255)
    
    public static var screenOrange = Color.init(red: 239/255, green: 189/255, blue: 134/255)
    
    public static var screenBlue = Color.init(red: 134/255, green: 206/255, blue: 239/255)
    
    public static var screenYellow = Color.init(red: 239/255, green: 223/255, blue: 134/255)
    
    public static var screenLightBlue = Color.init(red: 134/255, green: 239/255, blue: 234/255)
    
    public static var screenlightGreen = Color.init(red: 172/255, green: 239/255, blue: 134/255)
}
