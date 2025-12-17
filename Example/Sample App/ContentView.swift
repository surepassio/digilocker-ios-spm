//
//  ContentView.swift
//
//  Created by Alish Kumar on 28/08/25.
//

import SwiftUI

// MARK: - ContentView with Enhanced Delegate Support
import SwiftUI
import Digilocker_Framework

struct ContentView: View {
    @State private var initSDK: Bool = false
    @State private var token: String = ".eJyrVkrOyUzNK4nPTFGyUkrJTM_MyU_OTi2KT89OzEovjSrzyc4tSqnIdS1zz8pW0lFKTyxJLU-sBKotKMpPKU0uyczPAwqXVBakouhXqgUA59og1Q.aUKfjw.RKpTlxlUn5BKWl-sxsDNaFiMiAI"
    @State private var errorMessage: String = ""
    private var env: String = Env.PROD.rawValue
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination:
                                InitSDKView(
                    environment: env,
                    token: token,
                    onCompletion: { clientId in
                        print("SDK RESPONSE SUCCESS: ", clientId)
                        errorMessage = ""
                        token = clientId
                    },
                    onFailure: { result in
                        print("SDK RESPONSE ERROR: ", result)
                        errorMessage = result
                    }
                ), isActive: $initSDK) {
                }
                Text("")
                    .frame(height: 100)
                // Card-like container
                VStack(spacing: 20) {
                    // Logo + Title
                    Image(.surepass)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Enter API Token")
                            .font(.title)
                            .foregroundColor(.black)
                        
                        Text("Paste your API login token here")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // TextField
                    TextField("API Login Token", text: $token)
                        .foregroundColor(.black)
                        .autocorrectionDisabled(true)       // disables autocorrection (iOS 15+)
                        .textInputAutocapitalization(.never)
                        .padding() // internal padding
                        .frame(height: 50) // control height
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                        .overlay(
                            // Custom placeholder when text is empty
                            HStack {
                                if token.isEmpty {
                                    Text("API Login Token")
                                        .foregroundColor(.gray.opacity(0.6)) // Hint/placeholder color
                                        .padding(.leading, 16)
                                    Spacer()
                                }
                            }
                        )
                        .accentColor(.black)
                        .padding(.top, 4)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .font(.headline)
                            .foregroundColor(Color.red)
                            .padding(.top, 20)
                    }
                    
                    // Button
                    Button(action: {
                        initSDK = true
                    }) {
                        HStack {
                            Text("Get Started")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 176/255, green: 38/255, blue: 92/255)) // same as your pinkish-red
                        .cornerRadius(8)
                    }
                    .padding(.top, 50)
                }
                .padding()
                .padding(.horizontal, 16)
                
                Spacer()
                
                // Footer
                HStack(spacing: 4) {
                    Text("Powered by")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Image(.surepass)
                    
                }
                .background(Color.white)
                .cornerRadius(12)
                .padding(.bottom, 20)
            }
            .background(Color.white)
            .ignoresSafeArea(.keyboard)
            .background(Color.white)
        }
        .onAppear() {
            SurepassConfig.shared.accentColor = .blue
        }
        .ignoresSafeArea(.keyboard)
    }
}
#Preview {
    ContentView()
}
