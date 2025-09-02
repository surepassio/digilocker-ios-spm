//
//  WebView.swift
//  Sample App
//
//  Created by Alish Kumar on 29/08/25.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // If you want to reload or update when URL changes
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "https://www.apple.com")!)
}
