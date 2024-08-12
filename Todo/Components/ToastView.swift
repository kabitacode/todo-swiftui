//
//  ToastView.swift
//  Todo
//
//  Created by Zulfiqor on 12/08/24.
//

import SwiftUI

struct ToastView: View {
    var message: String
    var body: some View {
       Text(message)
            .foregroundStyle(.white)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(8)
            .padding(.horizontal, 20)
    }
}
