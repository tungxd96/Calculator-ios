//
//  Math.swift
//  Calculator
//
//  Created by Tung Dinh on 3/28/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct Math {
    
    static func computeCalcEquation(equation: Equation, nodeSet: [[Node]]) -> [String] {
        var result: [String] = []
        switch equation {
        case .linear:
            result = computeLinearEquation(nodes: nodeSet[0])
        case .quadratic:
            result = computeQuadraticEquation(nodes: nodeSet[0])
        case .cubic, .quartic:
            result = computeExpandPolynomialEquation(nodes: nodeSet[0], degree: equation.degree)
        case .sim2:
            result = computeSim2Equation(nodes: nodeSet)
        case .sim3:
            result = computeSim3Equation(nodes: nodeSet)
        default:
            return result
        }
        return result
    }
    
    static func computeLinearEquation(nodes: [Node]) -> [String] {
        var result: [String] = []
        
        if !nodes.isEmpty {
            if nodes.count == Equation.linear.degree + 1 {
                
                let a: Double = Double(nodes[0].data)!
                let b: Double = Double(nodes[1].data)!
                
                let x: Double = -b / a
                
                result.append(String(roundDecimal(base: x, decimal: 8)))
            }
        }
        
        return result
    }
    
    static func computeQuadraticEquation(nodes: [Node]) -> [String] {
        var result: [String] = []
        
        if !nodes.isEmpty {
            if nodes.count == Equation.quadratic.degree + 1 {
                
                let a: Double = Double(nodes[0].data)!
                let b: Double = Double(nodes[1].data)!
                let c: Double = Double(nodes[2].data)!
                let delta = pow(b, 2) - (4 * a * c)
                
                var x1: String
                var x2: String
                
                if delta < 0 {
                    let real: Double = self.roundDecimal(base: -b / (2 * a), decimal: 8)
                    let imaginary: Double = self.roundDecimal(base: sqrt(abs(delta)) / (2 * a), decimal: 8)
                    let realStr = validateNumType(base: real)
                    let imaginaryStr = validateImaginary(base: imaginary)
                    x1 = realStr + " + " + imaginaryStr
                    x2 = realStr + " - " + imaginaryStr
                }
                else {
                    let x1d: Double = (-b + sqrt(abs(delta))) / (2 * a)
                    let x2d: Double = (-b - sqrt(abs(delta))) / (2 * a)
                    x1 = String(self.roundDecimal(base: x1d, decimal: 8))
                    x2 = String(self.roundDecimal(base: x2d, decimal: 8))
                }
                
                
                result.append(x1)
                result.append(x2)
                
            }
        }
        
        return result
    }
    
    static func computeExpandPolynomialEquation(nodes: [Node], degree: Int) -> [String] {
        var result: [String] = []
        
        if !nodes.isEmpty {
            if nodes.count == degree + 1 {
                
                let p: Double = Double(nodes[nodes.count - 1].data)!
                let q: Double = Double(nodes[0].data)!
                
                // Step 1: Find divisors of Q (a) and P (d)
                let cases: [Double] = findHornerPreTrials(p: abs(p), q: abs(q))
                
                var equation: [Double] = []
                equation.append(q)
                
                // Perform Horner's method
                for i in cases {
                    for j in 1..<nodes.count {
                        let prev = equation[j - 1]
                        let cur = Double(nodes[j].data)!
                        equation.append(i * prev + cur)
                    }
                    if equation[nodes.count - 1] == 0 {
                        result.append(String(roundDecimal(base: i, decimal: 8)))
                        break
                    }
                    else {
                        equation.removeAll()
                        equation.append(q)
                    }
                }
                
                var subNodes: [Node] = []
                let subDegree = equation.count - 2
                
                for i in 0..<equation.count - 1 {
                    subNodes.append(Node(data: String(equation[i])))
                }
                
                if subNodes.isEmpty {
                    if degree == Equation.quartic.degree {
                        result = computeQuarticEquation(nodes: nodes)
                    }
                    else if degree == Equation.cubic.degree {
                        result = computeCubicEquation(nodes: nodes)
                    }
                }
                
                let subResult = subDegree <= 2 ? computeQuadraticEquation(nodes: subNodes) : computeExpandPolynomialEquation(nodes: subNodes, degree: equation.count - 2)
                
                for i in subResult {
                    if !result.contains(i) {
                        if isOperand(s: i) {
                            result.append(String(roundDecimal(base: Double(i)!, decimal: 8)))
                        }
                        else {
                            result.append(i)
                        }
                    }
                }
                
            }
        }
        
        return result
    }
    
    static func computeQuarticEquation(nodes: [Node]) -> [String] {
        
        let a = Double(nodes[0].data)!
        let b = Double(nodes[1].data)!
        let c = Double(nodes[2].data)!
        let d = Double(nodes[3].data)!
        let e = Double(nodes[4].data)!
        
        let f = c - ((3 * pow(b, 2)) / 8)
        let g = d + (pow(b, 3) / 8) - ((b * c) / 2)
        let h = e - ((3 * pow(b, 4)) / 256) + (pow(b, 2) * c / 16) - (b * d / 4)
        
        let a3: Double = 1
        let b3: Double = f / 2
        let c3: Double = (pow(f, 2) - 4 * h) / 16
        let d3: Double = -pow(g, 2) / 64
        
        var cubicNodes: [Node] = []
        cubicNodes.append(Node(data: String(a3)))
        cubicNodes.append(Node(data: String(b3)))
        cubicNodes.append(Node(data: String(c3)))
        cubicNodes.append(Node(data: String(d3)))
        
        let cubicResult = computeExpandPolynomialEquation(nodes: cubicNodes, degree: Equation.cubic.degree)
        
        return []
    }
    
    static func computeCubicEquation(nodes: [Node]) -> [String] {
        
        var result: [String] = []
        
        let a = Double(nodes[0].data)!
        let b = Double(nodes[1].data)!
        let c = Double(nodes[2].data)!
        let d = Double(nodes[3].data)!
        
        let p = -b / (3 * a)
        let q = pow(p, 3) + (((b * c) - (3 * a * d)) / (6 * pow(a, 2)))
        let r = c / (3 * a)
        
        let cubicRoot: Double = 1.0 / 3.0
        let x1: Double = (q + pow((pow(q, 2) + pow((r - pow(p, 2)), 3)), 0.5))
        let x2: Double = (q - pow((pow(q, 2) + pow((r - pow(p, 2)), 3)), 0.5))
        let x1Cubic: Double = pow(abs(x1), cubicRoot)
        let x2Cubic: Double = pow(abs(x2), cubicRoot)
        let x1Final: Double = x1 < 0 ? -x1Cubic : x1Cubic
        let x2Final: Double = x2 < 0 ? -x2Cubic : x2Cubic
        
        let x: Double = x1Final + x2Final + p
        
        result.append(String(roundDecimal(base: x, decimal: 8)))
        
        return result
    }
    
    static func computeFx(x: Double, f: [Node]) -> Double {
        let degree: Int = f.count - 1
        var total: Double = 0.0
        
        for i in 0..<f.count {
            let exp: Double = Double(degree - i)
            let constant: Double = Double(f[i].data)!
            total += constant * pow(x, exp)
        }
        
        return total
    }
    
    static func findHornerPreTrials(p: Double, q: Double) -> [Double] {
        let divQ = factors(of: Int(q))
        let divP = factors(of: Int(p))
        
        var cases: [Double] = []
        
        for i in p > q ? divQ : divP {
            for j in p > q ? divP : divQ {
                if i == 0 {
                    cases.append(0)
                    break
                }
                let div: Double = Double(j) / Double(i)
                if !cases.contains(div) {
                    cases.append(div)
                    cases.append(-div)
                }
            }
        }
        
        return cases
    }
    
    static func computeSim2Equation(nodes: [[Node]]) -> [String] {
        var result: [String] = []
        
        if !nodes.isEmpty {
            if nodes.count == Equation.sim2.degree {
                if nodes[0].count == Equation.sim2.degree + 1 && nodes[1].count == Equation.sim2.degree + 1 {
                    
                    let a1: Double = Double(nodes[0][0].data)!
                    let b1: Double = Double(nodes[0][1].data)!
                    let c1: Double = Double(nodes[0][2].data)!
                    let a2: Double = Double(nodes[1][0].data)!
                    let b2: Double = Double(nodes[1][1].data)!
                    let c2: Double = Double(nodes[1][2].data)!
                    
                    let y = (a1 * c2 - a2 * c1) / (a1 * b2 - a2 * b1)
                    let x = (c1 - b1 * y) / a1
                    
                    result.append(String(roundDecimal(base: x, decimal: 8)))
                    result.append(String(roundDecimal(base: y, decimal: 8)))
                    
                }
            }
        }
        
        return result
    }
    
    static func computeSim3Equation(nodes: [[Node]]) -> [String] {
        var result: [String] = []
        if !nodes.isEmpty {
            if nodes.count == Equation.sim3.degree {
                if nodes[0].count == Equation.sim3.degree + 1
                    && nodes[1].count == Equation.sim3.degree + 1
                    && nodes[2].count == Equation.sim3.degree + 1 {
                    
                    let a1: Double = Double(nodes[0][0].data)!
                    let b1: Double = Double(nodes[0][1].data)!
                    let c1: Double = Double(nodes[0][2].data)!
                    let d1: Double = Double(nodes[0][3].data)!
                    let a2: Double = Double(nodes[1][0].data)!
                    let b2: Double = Double(nodes[1][1].data)!
                    let c2: Double = Double(nodes[1][2].data)!
                    let d2: Double = Double(nodes[1][3].data)!
                    let a3: Double = Double(nodes[2][0].data)!
                    let b3: Double = Double(nodes[2][1].data)!
                    let c3: Double = Double(nodes[2][2].data)!
                    let d3: Double = Double(nodes[2][3].data)!
                    
                    let A1 = a1 * b2 - a2 * b1
                    let B1 = a1 * c2 - a2 * c1
                    let C1 = a1 * d2 - a2 * d1
                    let A2 = a1 * b3 - a3 * b1
                    let B2 = a1 * c3 - a3 * c1
                    let C2 = a1 * d3 - a3 * d1
                    
                    let z = (A1 * C2 - A2 * C1) / (A1 * B2 - A2 * B1)
                    let y = (C1 - B1 * z) / A1
                    let x = (d1 - b1 * y - c1 * z) / a1
                    
                    result.append(String(roundDecimal(base: x, decimal: 8)))
                    result.append(String(roundDecimal(base: y, decimal: 8)))
                    result.append(String(roundDecimal(base: z, decimal: 8)))
                    
                }
            }
        }
        return result
    }
    
    static func factors(of n: Int) -> [Int] {
        if n == 0 {
            return [0]
        }
        let sqrtn = Int(Double(n).squareRoot())
        var factors: [Int] = []
        factors.reserveCapacity(2 * sqrtn)
        for i in 1...sqrtn {
            if n % i == 0 {
                factors.append(i)
            }
        }
        var j = factors.count - 1
        if factors[j] * factors[j] == n {
            j -= 1
        }
        while j >= 0 {
            factors.append(n / factors[j])
            j -= 1
        }
        return factors
    }
    
    static func validateNumType(base: Double) -> String {
        return isDecimalNumber(base: base) ? String(base) : String(Int(base))
    }
    
    static func validateNumType(base: String) -> String {
        return isDecimalNumber(base: base) ? base : String(Int(base)!)
    }
    
    static func validateImaginary(base: Double) -> String {
        return base == 1 ? "i" : validateNumType(base: base) + "i"
    }
    
    static func toRadian(degree: Double) -> Double {
        return degree * Double.pi / 180.0
    }
    
    static func toDegree(radian: Double) -> Double {
        return radian * 180.0 / Double.pi
    }
    
    static func priority(s: String) -> Int {
        if s == "+" || s == "-" {
            return 1
        }
        else if s == "x" || s == "/" {
            return 2
        }
        else if s == "^" || s == "sqrt" {
            return 3
        }
        else if s == "%" {
            return 4
        }
        else if self.isFx(s: s) {
            return 5
        }
        else if s == "." {
            return 6
        }
        else {
            return 0
        }
    }
    
    static func isFx(s: String) -> Bool {
        return s == "sin" || s == "cos" || s == "tan"
            || s == "log" || s == "ln" || s == "asin" || s == "acos" || s == "atan" || s == "sqrt"
    }
    
    static func isFxCalculation(s: String) -> Bool {
        return self.isFx(s: s) || s == "%"
    }
    
    static func isOperand(s: String) -> Bool {
        let num = Int(s)
        return num != nil
    }
    
    static func isOperator(s: String) -> Bool {
        return !isOperand(s: s)
    }
    
    static func isDecimalNumber(base: Double) -> Bool {
        var roundNum = base
        roundNum.round(.up)
        return roundNum != base
    }
    
    static func isDecimalNumber(base: String) -> Bool {
        if !isOperand(s: base) {
            return false
        }
        var roundNum = Double(base)!
        roundNum.round(.up)
        return roundNum != Double(base)!
    }
    
    static func roundDecimal(base: Double, decimal: Int) -> Double {
        let decimalPlaces = pow(10.0, Double(decimal))  // 8th decimal places
        return Double(round(base * decimalPlaces) / decimalPlaces)
    }
    
    static func verifyNum(num: Double) -> String {
        return self.isDecimalNumber(base: num)
            ? String(num)
            : String(Int(num))
    }
}
