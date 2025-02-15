//
//  CalculusEquationView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/26/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct AlgebraicEquation: View {
    
    var exponential: Int
    
    var body: some View {
        HStack {
            ForEach (0 ..< exponential + 1, id: \.self) { i in
                HStack {
                    Text(AsciiTable.lowerAlpha[i])
                    PowerElement(base: "x", exponential: self.reverseExponential(exp: i))
                    self.addPlus(i: i)
                    self.addEqual(i: i)
                }
            }
        }
    }
    
    func addPlus(i: Int) -> some View {
        if i != self.exponential {
            return AnyView(Text("+"))
        }
        return AnyView(Text(""))
    }
    
    func addEqual(i: Int) -> some View {
        if i == self.exponential {
            return AnyView(
                HStack {
                    Text("=")
                    Text("0")
                }
            )
        }
        return AnyView(Text(""))
    }
    
    func reverseExponential(exp: Int) -> String {
        return String(self.exponential - exp)
    }
}

struct AlgebraicEquation_Previews: PreviewProvider {
    static var previews: some View {
        AlgebraicEquation(exponential: 2)
    }
}
