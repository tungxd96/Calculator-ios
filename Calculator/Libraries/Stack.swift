//
//  Stack.swift
//  Calculator
//
//  Created by Tung Dinh on 3/27/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import Foundation

struct Stack<Element> {
    private var items: [Element] = []
    
    func peek() -> Element {
        guard let topElement = items.first else { fatalError("This stack is empty.") }
        return topElement
    }
    
    mutating func pop() -> Element {
        return items.removeFirst()
    }
  
    mutating func push(_ element: Element) {
        items.insert(element, at: 0)
    }
    
    var isEmpty: Bool {
      return items.isEmpty
    }

    var count: Int {
      return items.count
    }
    
    mutating func clear() {
        items.removeAll()
    }
}
