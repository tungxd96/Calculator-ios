//
//  DefaultNumpadView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct DefaultNumpadView: View {
    
    var button: CalculatorButton
    
    var body: some View {
        if button.isExponential {
            return AnyView(ExponentialView(base: "x", exponential: button.label, button: button))
        }
        else if button.isOperator || button.isEqual || button.isDel || button.isPercent {
            return AnyView(OperatorView(button: button))
        }
        else {
            return AnyView(ArithmeticView(button: button))
        }
    }
}

struct DefaultNumpadView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultNumpadView(button: CalculatorButton.one)
    }
}
