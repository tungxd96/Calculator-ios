//
//  ResultDisplayView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/26/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ResultDisplayView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let defaultPadding: CGFloat = 32
    
    var body: some View {
        ZStack {
            Color(.lightGray).opacity(0.1)
            .cornerRadius(16)
            HStack {
                Text(self.receiveText(tag: .general))
                    .foregroundColor(.black)
                    .font(.system(size: 32))
                    .frame(height: displayHeight())
                Spacer()
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.blue, lineWidth: self.env.focus == .general ? 1 : 0)
        )
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
        .onTapGesture {
            if self.env.focus != .general {
                self.env.clear()
            }
            self.env.focus = .general
        }
    }
    
    func receiveText(tag: Tag) -> String {
        return self.env.focus == tag ? self.env.display : ""
    }
    
    func displayHeight() -> CGFloat {
        let buttonHeight = (UIScreen.main.bounds.width - 10 * 12) / 4
        let numpadHeight = CGFloat(buttonHeight * 5) + CGFloat(self.defaultPadding * 6)
        let modeHeight = 50 + self.defaultPadding
        return UIScreen.main.bounds.height - numpadHeight - modeHeight
    }
}

struct ResultDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ResultDisplayView().environmentObject(GlobalEnvironment())
    }
}
