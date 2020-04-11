//
//  InputElementView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct InputElement: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var tags: [Tag]
    var nodes: [Node]
    var i: Int
    var j: Int
    
    var body: some View {
        VStack {
            self.labelView()
            Text(self.receiveText())
                .frame(width: 160, height: 50)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    self.onTap()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.blue, lineWidth: self.env.focus == self.tags[j] ? 1 : 0)
            )
        }
    }
    
    func labelView() -> some View {
        switch self.env.mode {
        case .algebraic:
            return AnyView(
                Text(AsciiTable.lowerAlpha[j])
                    .padding(.bottom, 16)
            )
        case .simultaneous:
            return AnyView(
                SubscriptElement(base: AsciiTable.lowerAlpha[j], sub: String(i))
                    .padding(.bottom, 16)
            )
        case .exponential:
            return AnyView(EmptyView())
        }
    }
    
    func onTap() {
        self.env.focus = self.tags[self.j]
        if self.nodes[self.j].get() == "" {
            self.env.clear()
        }
        else {
            self.env.display = self.nodes[self.j].get()
        }
    }
    
    func receiveText() -> String {
        if self.env.focus == self.tags[j] {
            if self.env.display != "" {
                if nodes[j].get() == self.env.display {
                    self.env.clear()
                }
            }
            nodes[j].update(data: self.env.display)
        }
        return self.env.focus == self.tags[j] ? self.env.display : nodes[j].get()
    }
}

struct InputElement_Previews: PreviewProvider {
    static var previews: some View {
        InputElement(
            tags: [.linear_a],
            nodes: [Node(data: "")],
            i: 0,
            j: 0
        )
        .environmentObject(GlobalEnvironment())
    }
}
