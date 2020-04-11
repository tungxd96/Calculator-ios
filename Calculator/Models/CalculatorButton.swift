//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Tung Dinh on 3/25/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    
    case shift, mode
    case sin, cos, tan, log, ln, asin, acos, atan
    case pow2, powk, openBracket, closeBracket, sqrt
    case zero, one, two, three, four, five, six, seven, eight, nine, decimal
    case plus, equal, minus, multiply, divide
    case ac, ans, percent, del
    
    var shiftPressedBackgroundColor: Color {
        return Color(.systemGray6)
    }
    
    var shiftPressedForegroundColor: Color {
        return Color(.systemIndigo)
    }
    
    var backgroundColor: Color {
        switch self {
        case .ac, .del:
            return .red
        case .plus, .equal, .minus, .multiply, .divide, .ans:
            return .blue
        case .openBracket, .closeBracket, .sin, .cos, .tan, .pow2, .powk, .log, .ln, .percent, .sqrt:
            return Color(.systemTeal)
        case .shift, .mode:
            return Color(.systemIndigo)
        default:
            return Color(.lightGray).opacity(0.3)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .zero, .decimal:
            return .black
        default:
            return .white
        }
    }
    
    var label: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "x"
        case .equal: return "="
        case .divide: return "/"
        case .decimal: return "."
        case .ans: return "Ans"
        case .percent: return "%"
        case .del: return "Del"
        case .openBracket: return "("
        case .closeBracket: return ")"
        case .sin: return "sin"
        case .cos: return "cos"
        case .tan: return "tan"
        case .log: return "log"
        case .ln: return "ln"
        case .pow2: return "2"
        case .powk: return "n"
        case .ac: return "AC"
        case .asin: return "asin"
        case .acos: return "acos"
        case .atan: return "atan"
        case .sqrt: return "sqrt"
        default:
            return ""
        }
    }
    
    var iconData: String {
        switch self {
        case .plus: return "plus"
        case .minus: return "minus"
        case .multiply: return "multiply"
        case .divide: return "divide"
        case .equal: return "equal"
        case .del: return "delete.left"
        case .sqrt: return "x.squareroot"
        case .percent: return "percent"
        default:
            return ""
        }
    }
    
    var shiftHold: CalculatorButton {
        switch self {
        case .sin: return .asin
        case .cos: return .acos
        case .tan: return .atan
        case .pow2: return .sqrt
        default:
            return self
        }
    }
    
    var shiftRelease: CalculatorButton {
        switch self {
        case .asin: return .sin
        case .acos: return .cos
        case .atan: return .tan
        case .sqrt: return .pow2
        default:
            return self
        }
    }
    
    var keyLabel: String {
        switch self {
        case .shift: return "Shift"
        case .mode: return "Mode"
        default:
            return ""
        }
    }
    
    var isSqrt: Bool {
        return self == .sqrt
    }
    
    var isExponential: Bool {
        return self == .pow2 || self == .powk
    }
    
    var isNumeric: Bool {
        switch self {
        case .zero, .one, .two, .three, .four, .five
        , .six, .seven, .eight, .nine:
            return true
        default:
            return false
        }
    }
    
    var isEqual: Bool {
        return self == .equal
    }
    
    var isClear: Bool {
        return self == .ac
    }
    
    var isDecimal: Bool {
        return self == .decimal
    }
    
    var isPercent: Bool {
        return self == .percent
    }
    
    var isAns: Bool {
        return self == .ans
    }
    
    var isDel: Bool {
        return self == .del
    }
    
    var isPow2: Bool {
        return self == .pow2
    }
    
    var isOperator: Bool {
        return self == .plus || self == .minus || self == .multiply || self == .divide
    }
    
    var isTrigonometry: Bool {
        return self == .sin || self == .cos || self == .tan
    }
    
    var isLogarithm: Bool {
        return self == .log || self == .ln
    }
    
    var isShift: Bool {
        return self == .shift
    }
    
    var isMode: Bool {
        return self == .mode
    }
    
    var isExternalKey: Bool {
        return self.isShift || self.isMode
    }
}
