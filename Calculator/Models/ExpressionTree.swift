//
//  ExpressionTree.swift
//  Calculator
//
//  Created by Tung Dinh on 3/27/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

class ExpressionTree {
    
    func infixToPostfix(nodes: [Node]) -> [Node] {
        var stack = Stack<String>()
        var postfix: [Node] = []
        var reservedInfix: [Node] = nodes
        reservedInfix.insert(Node(data: "("), at: 0)
        reservedInfix.append(Node(data: ")"))
        for node in reservedInfix {
            if Math.isOperand(s: node.data) {
                postfix.append(node)
            }
            else if node.data == "(" {
                stack.push("(")
            }
            else if node.data == ")" {
                while stack.peek() != "(" {
                    postfix.append(Node(data: stack.pop()))
                }
                stack.pop()
            }
            else {
                if node.data != " " {
                    if Math.isOperator(s: stack.peek()) {
                        if !Math.isFx(s: stack.peek()) {
                            postfix.append(Node(data: " "))
                        }
                        while Math.priority(s: node.data) < Math.priority(s: stack.peek()) {
                            postfix.append(Node(data: stack.pop()))
                        }
                        stack.push(node.data)
                    }
                }
            }
        }
        return postfix
    }
    
    func infixToPrefix(nodes: [Node]) -> [Node] {
        let reversedInfix: [Node] = nodes.reversed()
        
        for node in reversedInfix {
            if node.data == "(" {
                node.update(data: ")")
            }
            
            else if node.data == ")" {
                node.update(data: "(")
            }
        }
        
        let postfix = self.infixToPostfix(nodes: reversedInfix)
        let prefix: [Node] = postfix.reversed()
        
        return prefix
    }
    
    func evaluatePrefix(nodes: [Node]) -> Double {
        let prefix = infixToPrefix(nodes: nodes)
        var i: Int = prefix.count - 1
        var stack = Stack<Double>()
        while i >= 0 {
            var num: Double = 0
            var digit: Double = 0
            var node = prefix[i]
            
            while Math.isOperand(s: node.data) && i >= 0 {
                let asciiValue: Double = Double(Character(prefix[i].data).asciiValue!) - 48
                
                if digit == 0 {
                    num = asciiValue
                }
                else {
                    num += pow(10, digit) * asciiValue
                }
                
                digit += 1
                i -= 1

                if i >= 0 {
                    if !Math.isOperand(s: prefix[i].data) {
                        stack.push(num)
                    }
                    node = prefix[i]
                }
                else {
                    if Math.isOperand(s: prefix[i + 1].data) {
                        stack.push(num)
                    }
                    node = prefix[i + 1]
                }
            }
            if i < 0 {
                break
            }
            
            if prefix[i].data == " " {
                i -= 1
                continue
            }
            if Math.isOperator(s: prefix[i].data) {
                if !stack.isEmpty && prefix[i].data != "" {
                    let o1: Double = stack.pop()
                    
                    let o2Empty: Bool = stack.isEmpty
                    let o2: Double = self.validate(s: prefix[i].data, stack: stack) ? 0.0 : stack.pop()
                    
                    switch prefix[i].data {
                    case ".":
                        let s: String = String(Int(o1)) + prefix[i].data + String(Int(o2))
                        stack.push(Double(s)!)
                    case "+":
                        stack.push(o1 + o2)
                    case "-":
                        stack.push(o2Empty ? o2 - o1 : o1 - o2);
                    case "/":
                        stack.push(o2 == 0.0 ? 0.0 : o1 / o2);
                    case "^":
                        stack.push(pow(o1, o2))
                    case "%":
                        stack.push(o1 / 100)
                    case "sin":
                        stack.push(sin(Math.toRadian(degree: o1)))
                    case "cos":
                        stack.push(cos(Math.toRadian(degree: o1)))
                    case "tan":
                        stack.push(tan(Math.toRadian(degree: o1)))
                    case "log":
                        stack.push(log10(o1))
                    case "ln":
                        stack.push(log(o1))
                    case "asin":
                        stack.push(Math.toDegree(radian: asin(o1)))
                    case "acos":
                        stack.push(Math.toDegree(radian: acos(o1)))
                    case "atan":
                        stack.push(Math.toDegree(radian: atan(o1)))
                    case "sqrt":
                        stack.push(sqrt(o1))
                    default:
                        stack.push(o1 * o2);
                    }
                }
            }
            i -= 1
        }
        return stack.peek()
    }
    
    func validate(s: String, stack: Stack<Double>) -> Bool {
        return Math.isFxCalculation(s: s) || stack.isEmpty
    }
    
    func printNodes(nodes: [Node]) {
        var s = ""
        for node in nodes {
            s.append(node.data)
        }
        print("Expression =", s)
    }
}

