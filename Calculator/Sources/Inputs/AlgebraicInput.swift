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
    
    var nodeSet: [[Node]]
    var equation: Equation
    
    var body: some View {
        self.content()
            .sheet(isPresented: self.$env.isEquationInfo, content: {
                WebView(url: self.equation.wikipediaUrl)
            })
    }
    
    func content() -> some View {
        if self.env.isEqInputClosed {
            return AnyView(
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Spacer()
                                
                                Text("Equation")
                                    .font(.title)
                                
                                Spacer()
                            }
                            
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
                        }
                        .padding(8)
                        
                        EquationTitle()
                        
                        VStack {
                            ForEach (0..<self.equation.tagSet.count, id: \.self) { i in
                                ScrollView (.horizontal, showsIndicators: false) {
                                    HStack (spacing: 24) {
                                        ForEach (0 ..< self.nodeSet[i].count, id: \.self) { j in
                                            InputElement(
                                                tags: self.equation.tagSet[i],
                                                nodes: self.nodeSet[i],
                                                i: i + 1,
                                                j: j
                                            )
                                        }
                                    }
                                    .padding(EdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 8))
                                }
                            }
                        }
                        
                        ZStack {
                            Button(action: {
                                self.env.focus = .general
                                self.env.equationResult = Math.computeCalcEquation(
                                    equation: self.equation,
                                    nodeSet: self.nodeSet
                                )
                                self.env.clear()
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
            nodeSet: [[Node(data: ""), Node(data: "")]],
            equation: .linear
        )
        .environmentObject(GlobalEnvironment())
    }
}
