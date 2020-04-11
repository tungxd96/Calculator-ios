//
//  ButtonDimension.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

class ButtonDimension {
    
    func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return self.buttonHeight() * 2 + 16
        }
        
        return self.buttonHeight()
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 14 * 12) / 4
    }
    
}
