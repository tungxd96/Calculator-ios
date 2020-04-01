//
//  EquationResultElement.swift
//  Calculator
//
//  Created by Tung Dinh on 3/30/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct CalcResultElement: View {
    
    var value: Double
    var index: Int
    
    let math = Math()
    
    var body: some View {
        VStack {
            SubscriptElement(base: "x", sub: String(index))
                .padding()
            Text(
                math.isDecimalNumber(base: self.value)
                    ? String(self.value)
                    : String(Int(self.value))
            )
            .frame(width: 160, height: 50)
            .background(Color.white)
            .cornerRadius(50)
        }
    }
}

struct CalcResultElement_Previews: PreviewProvider {
    static var previews: some View {
        CalcResultElement(value: 0.0, index: 1)
    }
}
