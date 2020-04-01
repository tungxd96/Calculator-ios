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
    
    var body: some View {
        VStack {
            Text(String(Character(UnicodeScalar(97 + i) ?? UnicodeScalar(97))))
                .padding(.bottom, 16)
            Text(self.receiveText(
                    node: nodes[i],
                    tag: self.tags[i]
                )
            )
                .frame(width: 160, height: 50)
                .background(Color.white)
                .cornerRadius(50)
                .onTapGesture {
                    self.onTap()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.blue, lineWidth: self.env.focus == self.tags[i] ? 1 : 0)
            )
        }
    }
    
    func onTap() {
        self.env.focus = self.tags[self.i]
        if self.nodes[self.i].get() == "" {
            self.env.clear()
        }
        else {
            self.env.display = self.nodes[self.i].get()
        }
    }
    
    func receiveText(node: Node, tag: Tag) -> String {
        if self.env.focus == tag {
            if self.env.display != "" {
                if node.get() == self.env.display {
                    self.env.clear()
                }
            }
            node.update(data: self.env.display)
        }
        return self.env.focus == tag ? self.env.display : node.get()
    }
}

struct InputElement_Previews: PreviewProvider {
    static var previews: some View {
        InputElement(tags: [.linear_a], nodes: [Node(data: "")], i: 0).environmentObject(GlobalEnvironment())
    }
}
