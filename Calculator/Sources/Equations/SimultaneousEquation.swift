//
//  SimultaneousEquationView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct SimultaneousElement: View {
    
    var sets: Int
    
    var body: some View {
        HStack {
            ForEach(0..<sets, id: \.self) { i in
                HStack {
                    Text(String(Character(UnicodeScalar(97 + i) ?? UnicodeScalar(97))))
                    Text(String(Character(UnicodeScalar(120 + i) ?? UnicodeScalar(120))))
                    self.addPlus(i: i)
                    self.addEqual(i: i)
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
    
    func addEqual(i: Int) -> some View {
        if i == sets - 1 {
            return AnyView(
                HStack {
                    Text("=")
                    Text(String(Character(UnicodeScalar(97 + i + 1) ?? UnicodeScalar(97))))
                }
            )
        }
        return AnyView(Text(""))
    }
}

struct SimultaneousElement_Previews: PreviewProvider {
    static var previews: some View {
        SimultaneousElement(sets: 2)
    }
}
