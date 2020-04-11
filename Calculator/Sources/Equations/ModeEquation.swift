//
//  AlgebraicEquationView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ModeEquation: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var mode: Mode
    
    var body: some View {
        ForEach(self.mode.equations, id: \.self) { equation in
            ZStack {
                Button(action: {
                    self.env.mode = self.mode
                    self.env.equation = equation
                    self.env.equationResult.removeAll()
                    withAnimation {
                        self.env.isEqInputClosed = true
                        self.env.isEquation.toggle()
                        self.env.isMode.toggle()
                    }
                }) {
                    self.content(equation: equation)
                }
            }
            .background(Color.blue)
            .cornerRadius(20)
            .padding()
        }
    }
    
    func content(equation: Equation) -> some View {
        switch self.mode {
        case .algebraic:
            return AnyView(
                AlgebraicEquation(exponential: equation.degree)
                    .foregroundColor(Color.white)
                    .padding()
            )
        case .simultaneous:
            return AnyView(
                SimultaneousEquation(sets: equation.degree)
                    .foregroundColor(Color.white)
                    .padding()
            )
        case .exponential:
            return AnyView(
                ExponentialEquation()
                    .foregroundColor(Color.white)
                    .padding()
            )
        }
    }
}

struct ModeEquationView_Previews: PreviewProvider {
    static var previews: some View {
        ModeEquation(mode: Mode.exponential)
            .environmentObject(GlobalEnvironment())
    }
}
