//
//  GlobalEnvironment.swift
//  Calculator
//
//  Created by Tung Dinh on 3/25/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

class GlobalEnvironment: ObservableObject {
    
    @Published var display = ""
    
    func processInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.label
    }
}

