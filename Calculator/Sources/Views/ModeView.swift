//
//  ModeView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/29/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI

struct ModeView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let modes: [Mode] = [
        .algebraic, .simultaneous, .exponential
    ]
    
    let screen = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
    
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.env.isMode.toggle()
                            }
                        }, label: {
                            Text("Dismiss")
                                .font(.headline)
                                .foregroundColor(.blue)
                        })
                        
                        Spacer()
                        
                        Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.black)
                            .onTapGesture {
                                withAnimation {
                                    self.env.isMode.toggle()
                                }
                        }
                    }
                    .padding(.top, self.screen?.safeAreaInsets.top)
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                Spacer()
            }
            
            ScrollView (showsIndicators: false) {
                VStack (alignment: .leading) {
                    ForEach(modes, id: \.self) { mode in
                        VStack (alignment: .leading) {
                            Text(mode.title)
                                .font(.title)
                                .padding()
                            ModeEquation(mode: mode)
                        }
                    }
                }
            }
            .padding(.top, self.screen?.safeAreaInsets.top)
            .padding(.top, self.screen?.safeAreaInsets.top)
            
        }.background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .offset(x: 0, y: self.env.isMode ? 0 : self.screen?.frame.height ?? 0)
    }
}

struct ModeView_Previews: PreviewProvider {
    static var previews: some View {
        ModeView().environmentObject(GlobalEnvironment())
    }
}
