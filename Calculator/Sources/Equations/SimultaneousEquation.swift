//
//  SimultaneousEquationView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct SimultaneousEquation: View {
    
    var sets: Int
    
    var body: some View {
        VStack {
            ForEach (0..<self.sets, id: \.self) { i in
                HStack {
                    ForEach(0..<self.sets, id: \.self) { j in
                        HStack {
                            SubscriptElement(base: AsciiTable.lowerAlpha[j], sub: String(i + 1))
                            Text(AsciiTable.lowerAlpha[23 + j])
                            self.addPlus(i: j)
                            self.addEqual(i: i, j: j)
                        }
                    }
                }
            }
        }
    }
    
    func addPlus(i: Int) -> some View {
        if i != sets - 1 {
            return AnyView(Text("+"))
        }
        return AnyView(Text(""))
    }
    
    func addEqual(i: Int, j: Int) -> some View {
        if j == sets - 1 {
            return AnyView(
                HStack {
                    Text("=")
                    SubscriptElement(base: AsciiTable.lowerAlpha[j + 1], sub: String(i + 1))
                }
            )
        }
        return AnyView(Text(""))
    }
}

struct SimultaneousEquation_Previews: PreviewProvider {
    static var previews: some View {
        SimultaneousEquation(sets: 2)
    }
}
