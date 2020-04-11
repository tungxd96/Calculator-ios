//
//  ModeButton.swift
//  Calculator
//
//  Created by Tung Dinh on 3/25/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

enum Equation: String {
    case linear, quadratic, cubic, quartic, sim2, sim3, exponential, none
    
    var degree: Int {
        switch self {
        case .linear: return 1
        case .quadratic, .sim2: return 2
        case .cubic, .sim3: return 3
        case .quartic: return 4
        default: return 0
        }
    }
    
    var tagSet: [[Tag]] {
        switch self {
        case .linear:
            return [[.linear_a, .linear_b]]
        case .quadratic:
            return [[.quadratic_a, .quadratic_b, .quadratic_c]]
        case .cubic:
            return [[.cubic_a, .cubic_b, .cubic_c, .cubic_d]]
        case .quartic:
            return [[.quartic_a, .quartic_b, .quartic_c, .quartic_d, .quartic_e]]
        case .sim2:
            return [[.sim2_a1, .sim2_b1, .sim2_c1],
                    [.sim2_a2, .sim2_b2, .sim2_c2]]
        case .sim3:
            return [[.sim3_a1, .sim3_b1, .sim3_c1, .sim3_d1],
                    [.sim3_a2, .sim3_b2, .sim3_c2, .sim3_d2],
                    [.sim3_a3, .sim3_b3, .sim3_c3, .sim3_d3]]
        case.exponential:
            return [[]]
        default:
            return [[]]
        }
    }
    
    var wikipediaUrl: String {
        switch self {
        case .linear:
            return "https://en.wikipedia.org/wiki/Linear_equation"
        case .quadratic:
            return "https://en.wikipedia.org/wiki/Quadratic_equation"
        case .cubic:
            return "https://en.wikipedia.org/wiki/Cubic_equation"
        case .quartic:
            return "https://en.wikipedia.org/wiki/Quartic_function"
        case .sim2, .sim3:
            return "https://en.wikipedia.org/wiki/System_of_linear_equations"
        default:
            return "https://www.google.com"
        }
    }
    
}
