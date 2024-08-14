//
//  mock.swift
//  Todo
//
//  Created by Zulfiqor on 14/08/24.
//

import SwiftUI

struct mock: View {
    @State private var username: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            TextField("Username", text: $username)
                .frame(height: 55)
                .padding(.leading)
                .background(.gray.opacity(0.3), in: .rect(cornerRadius: 12))
               
        }
    }
}

#Preview {
    mock()
}
