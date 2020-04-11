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
    @Published var isShift = false
    @Published var isMode = false
    @Published var isEquation = false
    @Published var isEqInputClosed = false
    @Published var focus: Tag = .general
    @Published var equation = Equation.none
    @Published var mode = Mode.algebraic
    @Published var ans = 0.0
    @Published var equationResult: [String] = []
    @Published var isEquationInfo = false
    
    let expressionTree = ExpressionTree()
    let maxDecimalPlaces: Int = 8
    
    var nodes: [Node] = []
    var stack = Stack<String>()
    
    func processInput(calculatorButton: CalculatorButton) {
        var button: CalculatorButton = calculatorButton
        if self.isShift {
            button = button.shiftHold
        }
        else {
            button = button.shiftRelease
        }
        
        if button.isClear {
            self.clear()
        }
        
        else if button.isDel {
            if self.display != "" {
                var delElement = self.stack.pop()
                for _ in 0..<delElement.count {
                    self.display.removeLast()
                }
                delElement.removeLast()
                if Math.isFx(s: delElement) {
                    for _ in 0..<2 {
                        self.nodes.removeLast()
                    }
                } else {
                    self.nodes.removeLast()
                }
            }
        }
            
        else if button.isAns {
            let answer = Math.verifyNum(num: self.ans)
            self.display.append(button.label)
            self.stack.push(button.label)
            for i in answer {
                self.nodes.append(Node(data: String(i)))
            }
        }
        // Sin, cos, tan
        else if button.isTrigonometry
                || button.isLogarithm
                || button.isSqrt {
            
            var label = button.label
            
            self.nodes.append(Node(data: label))
            self.nodes.append(Node(data: "("))
            
            label.append("(")
            self.display.append(label)
            self.stack.push(label)
            
        }
            
        else if button.isDecimal {
            if stack.isEmpty {
                self.processSelfDecimal()
            }
            else {
                if Math.isOperator(s: stack.peek()) {
                    self.processSelfDecimal()
                }
            }
            let label = button.label
            self.display.append(label)
            self.stack.push(label)
            self.nodes.append(Node(data: label))
        }
            
        else if button.isExponential {
            var exp = "^"
            self.nodes.append(Node(data: exp))
            if button == CalculatorButton.pow2 {
                exp.append(button.label)
                self.nodes.append(Node(data: button.label))
            }
            self.display.append(exp)
            self.stack.push(exp)
        }
        
        else if button.isEqual {
            if self.display == "" {
                self.display = String(Int(self.ans))
            }
            let result = self.expressionTree.evaluatePrefix(nodes: self.nodes)
            let roundedResult = Math.roundDecimal(
                base: result,
                decimal: self.maxDecimalPlaces
            )
            
            self.ans = roundedResult
            
            self.display = Math.verifyNum(num: self.ans)
            
            while !stack.isEmpty {
                stack.pop()
            }
            
            stack.push(self.display)
            
        }
            
        else {
            if button.isOperator {
                let operatorSymbol = " " + button.label + " "
                self.display.append(operatorSymbol)
                self.stack.push(operatorSymbol)
                
                self.nodes.append(Node(data: " "))
                self.nodes.append(Node(data: button.label))
                self.nodes.append(Node(data: " "))
            }
            else {
                let label = button.label
                self.display.append(label)
                self.stack.push(label)
                self.nodes.append(Node(data: label))
            }
        }
    }
    
    func processSelfDecimal() {
        let label = "0"
        self.display.append(label)
        self.stack.push(label)
        self.nodes.append(Node(data: label))
    }
    
    func clear() {
        self.display = ""
        self.stack.clear()
        self.nodes.removeAll()
    }
    
}

