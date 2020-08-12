//
//  pageControl.swift
//  Onboarding
//
//  Created by Duvan Sanjaya on 24/07/20.
//  Copyright © 2020 Duvan Sanjaya. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct PageControl: UIViewRepresentable {
    
    var numberOfPages: Int
    
    @Binding var currentPageIndex: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        control.currentPageIndicatorTintColor = UIColor.systemBlue
        control.pageIndicatorTintColor = UIColor.systemTeal
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPageIndex
    }
    
}
