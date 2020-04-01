//
//  LinearView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct AlgebraicInput: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var nodes: [Node]
    var tags: [Tag]
    var equation: Equation
    
    let math = Math()
    
    var body: some View {
        self.content()
    }
    
    func content() -> some View {
        if self.env.isEqInputClosed {
            return AnyView(
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.env.isEqInputClosed.toggle()
                            }) {
                                Image(systemName: "xmark.circle")
                                    .padding(8)
                                    .foregroundColor(Color.black)
                            }
                        }
                        
                        EquationTitle()
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack (spacing: 24) {
                                ForEach (0 ..< self.nodes.count, id: \.self) { i in
                                    InputElement(tags: self.tags, nodes: self.nodes, i: i)
                                }
                            }
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                        }
                        
                        ZStack {
                            Button(action: {
                                self.env.equationResult = self.math.computeCalcEquation(
                                    equation: self.equation,
                                    nodes: self.nodes
                                )
                            }) {
                                Text("Solve")
                                    .foregroundColor(.white)
                                    .padding(12)
                            }
                        }
                        .background(Color.green)
                        .cornerRadius(20)
                        
                        self.displayResult()
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 16, trailing: 8))
                    .background(Color(.systemGray6).opacity(0.5))
                    .cornerRadius(20)
                
                }
                .padding(8)
            )
        }
        else {
            return AnyView(EmptyView())
        }
    }
    
    func displayResult() -> some View {
        if !self.env.equationResult.isEmpty {
            return AnyView(
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack (spacing: 24) {
                            ForEach (0..<self.env.equationResult.count, id: \.self) { i in
                                CalcResultElement(
                                    value: self.env.equationResult[i],
                                    index: self.env.equationResult.count == 1 ? 0 : i + 1
                                )
                            }
                        }
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                    }
            )
        }
        return AnyView(EmptyView())
    }
    
}

struct AlgebraicInput_Previews: PreviewProvider {
    static var previews: some View {
        AlgebraicInput(
            nodes: [Node(data: "")],
            tags: [.linear_a],
            equation: .linear
        )
        .environmentObject(GlobalEnvironment())
    }
}