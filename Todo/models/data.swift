//
//  data.swift
//  Todo
//
//  Created by Zulfiqor on 24/07/24.
//

import Foundation

struct MockData: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted = false
}

extension MockData {
    static let samples = [
        MockData(title: "Wake Up!", isCompleted: true),
        MockData(title: "Work!", isCompleted: false),
        MockData(title: "Go to bathroom!", isCompleted: false),
        MockData(title: "Lunch!", isCompleted: false),
    ]
}
