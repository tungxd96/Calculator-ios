//
//  SubscriptElement.swift
//  Calculator
//
//  Created by Tung Dinh on 3/30/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct SubscriptElement: View {
    
    var base: String
    var sub: String
    
    var body: some View {
        HStack {
            Text(base)
                .offset(x: sub != "0" ? 3 : 0)
                .font(.system(size: 16))
            if sub != "0" {
                Text(sub)
                    .font(.system(size: 12))
                    .offset(x: -3, y: 5)
            }
        }
    }
}

struct SubscriptElement_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptElement(base: "a", sub: "1")
    }
}
