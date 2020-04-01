//
//  MyContactView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/28/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct MyContactView: View {
    
    @State var zoom = true
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .frame(height: 220)
                .animation(Animation.spring(response: 0.87, dampingFraction: 0.7, blendDuration: 1))
            
            HStack {
                Image("myAvatar")
                    .resizable()
                    .cornerRadius(50)
                    .frame(width: zoom ? 100 : 180, height: zoom ? 100 : 180)
                    .animation(Animation.spring(response: 0.87, dampingFraction: 0.7, blendDuration: 1))
                    .onTapGesture {
                        self.zoom.toggle()
                }
                VStack (alignment: .leading, spacing: 6){
                    Text("Tung Dinh")
                        .bold()
                        .foregroundColor(.white)
                        .animation(Animation.spring(response: 0.87, dampingFraction: 0.7, blendDuration: 1))
                    Text("tungxd96@uw.edu")
                        .font(.system(size: 14))
                        .bold()
                        .foregroundColor(.white)
                        .animation(Animation.spring(response: 0.87, dampingFraction: 0.7, blendDuration: 1))
                }
            }
            .padding()
        }
    }
}

struct MyContactView_Previews: PreviewProvider {
    static var previews: some View {
        MyContactView()
    }
}
