//
//  ContentView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/24/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        ZStack (alignment: .bottom) {
            Color.white.edgesIgnoringSafeArea(.all)
            ScrollView (showsIndicators: false) {
                VStack (spacing: 12) {
                    
                    // Title
                    Text("CALCULATOR")
                        .padding()
                    
                    // Display
                    ResultDisplayView()
                    
                    // Equation
                    EquationInputView(equation: self.env.equation)
                    
                    // Numpad
                    CalculatorButtonView()
                    
                    // Mode
                    //ModeButtonView()
                    
                    // Contact
                    MyContactView()
                    
                }
            }
            
            ModeView()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GlobalEnvironment())
    }
}
