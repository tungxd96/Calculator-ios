//
//  NumpadStyle.swift
//  Calculator
//
//  Created by Tung Dinh on 3/24/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

class NumpadStyle{
    let backgroundColor: Color
    let textColor: Color
    
    init(backgroundColor: Color, textColor: Color) {
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }
    
    init() {
        self.backgroundColor = NumpadColor.lightGray6
        self.textColor = NumpadColor.lightBlue
    }
}
