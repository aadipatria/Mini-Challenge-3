//
//  MotherView.swift
//  Onboarding
//
//  Created by Duvan Sanjaya on 25/07/20.
//  Copyright © 2020 Duvan Sanjaya. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ModuleInfo
    
    var body: some View {
        VStack{
            if viewRouter.currentPage == "onboardingView"{
                OnboardingView()
            }
            else if viewRouter.currentPage == "homeView"{
                ContentView().transition(.slide).animation(.easeInOut)
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ModuleInfo())
    }
}
