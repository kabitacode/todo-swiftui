//
//  LoginViewModels.swift
//  Todo
//
//  Created by Zulfiqor on 12/08/24.
//

import Foundation
import Combine

class LoginViewModels: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var user: User?
    @Published var errorMessage: String?
    
    private var cancelables = Set<AnyCancellable>()
    
    func handleLogin(){
        //input validate
        guard !username.isEmpty, !password.isEmpty else {
            self.errorMessage = "Username dan Password Belum Diisi!"
            return
        }
        
        AuthServices.shared.login(username: username, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login selesai tanpa kesalahan.")

                case .failure(let error):
                    print("Login gagal dengan error: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                }}, receiveValue: {user in
                    print("Login berhasil dengan user: \(user)")
                    self.user = user
                    self.errorMessage = nil
                })
            .store(in: &cancelables)
    }
}
