//
//  OperatorView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct OperatorView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    var button: CalculatorButton
    
    let buttonDimension = ButtonDimension()
    
    var body: some View {
        ZStack {
            Image(systemName: button.iconData)
                .font(.system(size: 16))
                .foregroundColor(button.foregroundColor)
        }
        .frame(
            width: buttonDimension.buttonWidth(button: button),
            height: buttonDimension.buttonHeight())
        .background(button.backgroundColor)
        .cornerRadius(50)
    }
}

struct OperatorView_Previews: PreviewProvider {
    static var previews: some View {
        OperatorView(button: CalculatorButton.sqrt).environmentObject(GlobalEnvironment())
    }
}
