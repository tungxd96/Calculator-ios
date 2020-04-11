//
//  EquationResultElement.swift
//  Calculator
//
//  Created by Tung Dinh on 3/30/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct CalcResultElement: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var value: String
    var index: Int
    
    var body: some View {
        VStack {
            self.label()
            Text(
                Math.isOperand(s: self.value)
                    ? Math.validateNumType(base: self.value)
                    : self.value
            )
            .frame(width: 160, height: 50)
            .background(Color.white)
            .cornerRadius(50)
        }
    }
    
    func label() -> some View {
        switch self.env.mode {
        case .algebraic:
            return AnyView(
                SubscriptElement(base: "x", sub: String(index))
                    .padding()
            )
        case .simultaneous:
            return AnyView(
                SubscriptElement(base: AsciiTable.lowerAlpha[22 + index], sub: "0")
                    .padding()
            )
        case .exponential:
            return AnyView(EmptyView())
        }
    }
}

struct CalcResultElement_Previews: PreviewProvider {
    static var previews: some View {
        CalcResultElement(value: "0", index: 1).environmentObject(GlobalEnvironment())
    }
}
