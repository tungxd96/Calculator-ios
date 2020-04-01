//
//  CalculatorButtonView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/25/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct CalculatorButtonView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let calculatorButtons: [[CalculatorButton]] = [
        [.shift, .mode],
        [.percent, .sin, .cos, .tan, .log],
        [.pow2, .powk, .openBracket, .closeBracket, .ln],
        [.seven, .eight, .nine, .del, .ac],
        [.four, .five, .six, .multiply, .divide],
        [.one, .two, .three, .plus, .minus],
        [.zero, .decimal, .ans, .equal],
    ]
    
    let buttonDimension = ButtonDimension()
    
    var body: some View {
        ForEach(calculatorButtons, id: \.self) { row in
            HStack (spacing: 12) {
                ForEach(row, id: \.self) { button in
                    Button(action: {
                        self.env.processInput(calculatorButton: button)
                        if button.isShift {
                            self.env.isShift.toggle()
                        }
                        else if button.isMode {
                            withAnimation {
                                self.env.isMode.toggle()
                            }
                        }
                    }) {
                        if self.env.isShift {
                            if button.isTrigonometry {
                                ExponentialView(base: button.label, exponential: "-1", button: button)
                            }
                            else if button.isPow2 {
                                OperatorView(button: button.shiftHold)
                            }
                            else {
                                DefaultNumpadView(button: button)
                            }
                        } else {
                            DefaultNumpadView(button: button)
                        }
                    }
                }
            }
        }
    }
}

struct CalculatorButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonView().environmentObject(GlobalEnvironment())
    }
}
