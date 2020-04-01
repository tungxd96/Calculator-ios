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
            let nodes: [Node] = self.generateNodes(degree: self.equation.degree)
            return AnyView(
                AlgebraicInput(
                    nodes: nodes,
                    tags: equation.tags,
                    equation: self.equation
                )
            )
        case .sim2, .sim3:
            let nodes: [Node] = self.generateNodes(degree: self.equation.degree * 2)
            return AnyView(
                AlgebraicInput(
                    nodes: nodes,
                    tags: equation.tags,
                    equation: self.equation
                )
            )
        case .exponential:
            return AnyView(Text(self.equation.rawValue))
        default:
            return AnyView(EmptyView())
        }
    }
    
    func generateNodes(degree: Int) -> [Node] {
        var nodes: [Node] = []
        for _ in 0...degree {
            nodes.append(Node(data: ""))
        }
        return nodes
    }
}

struct EquationInputView_Previews: PreviewProvider {
    static var previews: some View {
        EquationInputView(equation: .linear)
    }
}
