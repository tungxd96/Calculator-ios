//
//  ExponentialView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ExponentialView: View {
    
    var base: String
    var exponential: String
    var button: CalculatorButton
    
    let buttonDimension = ButtonDimension()
    
    var body: some View {
        ExponentialElement(base: base, exponential: exponential)
            .font(.system(size: 16))
            .frame(
                width: buttonDimension.buttonWidth(button: button),
                height: buttonDimension.buttonHeight())
            .foregroundColor(button.foregroundColor)
            .background(button.backgroundColor)
            .cornerRadius(50)
    }
}

struct ExponentialView_Previews: PreviewProvider {
    static var previews: some View {
        ExponentialView(base: "x", exponential: "2", button: CalculatorButton.pow2)
    }
}
