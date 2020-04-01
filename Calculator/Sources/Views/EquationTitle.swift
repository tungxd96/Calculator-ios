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
        ZStack {
            AlgebraicEquationElement(exponential: self.env.equation.degree)
                .foregroundColor(Color.white)
                .padding()
        }
        .background(Color.blue)
        .cornerRadius(20)
    }
}

struct EquationTitle_Previews: PreviewProvider {
    static var previews: some View {
        EquationTitle().environmentObject(GlobalEnvironment())
    }
}
