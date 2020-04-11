//
//  EquationInputView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct EquationInputView: View {
    
    var equation: Equation
    
    var body: some View {
        VStack {
            self.content()
        }
    }
    
    func content() -> some View {
        switch self.equation {
        case .linear, .quadratic, .cubic, .quartic:
            let nodeSet: [[Node]] = self.generateNodeSet(
                degree: self.equation.degree,
                round: 1
            )
            return AnyView(
                AlgebraicInput(
                    nodeSet: nodeSet,
                    equation: equation
                )
            )
        case .sim2, .sim3:
            let nodeSet: [[Node]] = self.generateNodeSet(
                degree: self.equation.degree,
                round: self.equation.degree
            )
            return AnyView(
                AlgebraicInput(nodeSet: nodeSet, equation: equation)
            )
        case .exponential:
            return AnyView(
                EquationTitle()
            )
        default:
            return AnyView(EmptyView())
        }
    }
    
    func generateNodeSet(degree: Int, round: Int) -> [[Node]] {
        var nodeSet: [[Node]] = []
        for i in 0..<round {
            nodeSet.append([])
            for _ in 0...degree {
                nodeSet[i].append(Node(data: ""))
            }
        }
        return nodeSet
    }
}

struct EquationInputView_Previews: PreviewProvider {
    static var previews: some View {
        EquationInputView(equation: .linear)
    }
}
