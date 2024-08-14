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
    @FocusState private var isFocus
    @FocusState private var isFocusPassword
    @State private var navigate: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(alignment: .leading, spacing: 10){
                    Text("Username").bold()
                    TextField("Enter your username", text: $viewModel.username)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(.gray.opacity(0.3), in: .rect(cornerRadius: 12))
                        .focused($isFocus)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12).stroke(isFocus ? .blue : .clear, lineWidth: 2)
                        }
                        .padding(.bottom, 10)
                    
                    Text("Password").bold()
                    SecureField("Enter your password", text:  $viewModel.password)
                        .frame(height: 55)
                        .padding(.leading)
                        .background(.gray.opacity(0.3), in: .rect(cornerRadius: 12))
                        .focused($isFocusPassword)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(isFocusPassword ? .blue : .clear, lineWidth: 2)
                        }
                        .padding(.bottom, 10)
                    
                    Button(action: {
                        viewModel.handleLogin()
                    }) {
                        Text("Login")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    if let user = viewModel.user {
                        Text("Welcome, \(user.username)!")
                            .padding()
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView(), isActive: $navigate){
                        
                    }
                }
                .padding()
                .navigationTitle("Login")
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
        .onReceive(viewModel.$user){ user in
            if user != nil {
                navigate = true
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
