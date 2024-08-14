//
//  AuthServices.swift
//  Todo
//
//  Created by Zulfiqor on 12/08/24.
//

import Foundation
import Combine

class AuthServices {
    static let shared = AuthServices()
    
    func login(username: String, password: String) -> AnyPublisher<User, Error>{
        let url = URL(string: "https://dummyjson.com/auth/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = ["username": username, "password": password]
        print(body)
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: User.self, decoder: JSONDecoder())
            .handleEvents(receiveOutput: { user in
                            // Cetak output yang diterima dari API
                            print("API Response: \(user)")
                        })
            .eraseToAnyPublisher()
    }
}
