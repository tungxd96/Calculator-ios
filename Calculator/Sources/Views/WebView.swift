//
//  WebView.swift
//  Calculator
//
//  Created by Tung Dinh on 3/30/20.
//  Copyright © 2020 Tung Dinh. All rights reserved.
//

import SwiftUI
import Foundation
import WebKit

struct WebView: UIViewRepresentable {
    
    @EnvironmentObject var env: GlobalEnvironment
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {

    }
    
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: "https://www.google.com").environmentObject(GlobalEnvironment())
    }
}
