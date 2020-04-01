//
//  ArithmeticView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ArithmeticView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var button: CalculatorButton
    
    let buttonDimension = ButtonDimension()
    
    var body: some View {
        Text(button.isExternalKey ? button.keyLabel : button.label)
            .font(.system(size: 16))
            .frame(
                width: buttonDimension.buttonWidth(button: button),
                height: buttonDimension.buttonHeight())
            .foregroundColor(self.env.isShift && button.isShift
                ? button.shiftPressedForegroundColor
                : button.foregroundColor)
            .background(self.env.isShift && button.isShift
                ? button.shiftPressedBackgroundColor
                : button.backgroundColor)
            .cornerRadius(50)
    }
}

struct ArithmeticView_Previews: PreviewProvider {
    static var previews: some View {
        ArithmeticView(button: CalculatorButton.one).environmentObject(GlobalEnvironment())
    }
}
