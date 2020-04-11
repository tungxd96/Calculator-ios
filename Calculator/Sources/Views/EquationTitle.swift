//
//  EquationTitleView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct EquationTitle: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Button(action: {
            withAnimation {
                self.env.isEquationInfo.toggle()
            }
        }) {
            ZStack {
                self.content()
            }
            .background(Color.blue)
            .cornerRadius(20)
        }
    }
    
    func content() -> some View {
        switch self.env.mode {
        case .algebraic:
            return AnyView(
                AlgebraicEquation(exponential: self.env.equation.degree)
                    .foregroundColor(Color.white)
                    .padding()
            )
        case .simultaneous:
            return AnyView(
                SimultaneousEquation(sets: self.env.equation.degree)
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

struct EquationTitle_Previews: PreviewProvider {
    static var previews: some View {
        EquationTitle().environmentObject(GlobalEnvironment())
    }
}
