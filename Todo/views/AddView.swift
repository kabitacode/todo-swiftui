//
//  AddView.swift
//  Todo
//
//  Created by Zulfiqor on 24/07/24.
//

import SwiftUI

struct AddView: View {
    enum FocusableField: Hashable {
        case title
    }
    
    @FocusState
    private var focusedField: FocusableField?
    
    @State private var data = MockData(title: "")
    
    @Environment(\.dismiss)
    private var dismiss
    
    var onSubmit: (_ data: MockData) -> Void
    
    private func submit() {
        onSubmit(data)
        dismiss()
    }
    
    private func cancel() {
        dismiss()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $data.title)
                    .focused($focusedField, equals: .title)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.cancellationAction){
                    Button(action: cancel){
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .confirmationAction){
                    Button(action: submit){
                        Text("Add")
                    }
                    .disabled(data.title.isEmpty)
                }
            }
            .onAppear {
                focusedField = .title
            }
        }
    }
}

#Preview {
    AddView{ mockdata in
        print("you added new task\(mockdata.title)")
    }
}
