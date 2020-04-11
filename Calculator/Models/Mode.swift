//
//  CalculusEquation.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

enum Mode: String {
    case algebraic, simultaneous, exponential
    
    var equations: [Equation] {
        switch self {
        case .algebraic: return [.linear, .quadratic, .cubic, .quartic]
        case .simultaneous: return [.sim2, .sim3]
        case .exponential: return [.exponential]
        }
    }
    
    var title: String {
        switch self {
        case .algebraic: return "Algebraic Equation"
        case .simultaneous: return "Simultaneous Equation"
        case .exponential: return "Exponential Equation"
        }
    }
}
