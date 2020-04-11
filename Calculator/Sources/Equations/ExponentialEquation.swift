//
//  ExponentialEquation.swift
//  Calculator
//
//  Created by Tung Dinh on 3/30/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ExponentialEquation: View {
    var body: some View {
        HStack {
            PowerElement(base: "a", exponential: "f(x)")
            Image(systemName: "equal")
            PowerElement(base: "b", exponential: "g(x)")
        }
    }
}

struct ExponentialEquation_Previews: PreviewProvider {
    static var previews: some View {
        ExponentialEquation()
    }
}
