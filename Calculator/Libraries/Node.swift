//
//  SwiftUIView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/28/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

class Node {
    var data: String
    
    init(data: String) {
        self.data = data
    }
    
    func update(data: String) {
        self.data = data
    }
    
    func get() -> String {
        return self.data
    }
}
