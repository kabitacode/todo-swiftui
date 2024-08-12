//
//  LoginViews.swift
//  Todo
//
//  Created by Zulfiqor on 12/08/24.
//

import SwiftUI

struct LoginViews: View {
    @StateObject private var viewModel = LoginViewModels()
    @State private var showToast: Bool = false

    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    TextField("Username", text: $viewModel.username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .autocapitalization(.none)
                        .onChange(of: viewModel.username) {newvalue in viewModel.username = newvalue.capitalized}
                    
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button(action: {
                        viewModel.handleLogin()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    if let user = viewModel.user {
                        Text("Welcome, \(user.username)!")
                            .padding()
                    }
                    
                    Spacer()
                }
                .navigationTitle("Login")
                .padding()
            }
            
            if showToast {
                VStack {
                    Spacer()
                    ToastView(message: viewModel.errorMessage ?? "")
                        .padding()
                }
                .transition(.slide)
                .animation(.easeInOut(duration: 0.5))
            }
        }
        .onReceive(viewModel.$errorMessage) { errorMessage in
            if errorMessage != nil {
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showToast = false
                }
            }
        }
    }
}

#Preview {
    LoginViews()
}
