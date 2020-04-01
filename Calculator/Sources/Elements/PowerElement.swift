//
//  ExponentialDisplayView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/26/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ExponentialElement: View {
    
    var base: String
    var exponential: String
    
    var body: some View {
        HStack {
            if exponential != "0" {
                Text(base)
                    .offset(x: exponential != "1" && exponential != "0" ? 3 : 0)
                    .font(.system(size: 16))
            }
            if exponential != "1" && exponential != "0" {
                Text(exponential)
                    .font(.system(size: 12))
                    .offset(x: -3, y: -5)
            }
        }
    }
}

struct ExponentialElement_Previews: PreviewProvider {
    static var previews: some View {
        ExponentialElement(base: "x", exponential: "2")
    }
}
