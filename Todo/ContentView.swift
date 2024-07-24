//
//  ContentView.swift
//  todo
//
//  Created by Zulfiqor on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var mockdata = MockData.samples
    
    @State private var isModal = false
    
    private func handleModalView(){
        isModal.toggle()
    }
    
    var body: some View {
        List($mockdata.indices, id: \.self) { index in
            HStack{
                Image(systemName: mockdata[index].isCompleted ? "largecircle.fill.circle" : "circle")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(mockdata[index].title)
                Spacer()
                Image(systemName: "xmark.circle").imageScale(.large).foregroundStyle(.tint)
                    .onTapGesture {
                        mockdata.remove(at: index)
                    }
            } .onTapGesture {
                mockdata[index].isCompleted.toggle()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button(action: handleModalView){
                    HStack {
                       Image(systemName: "plus.circle.fill")
                        Text("New Todo")
                    }
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isModal){
            AddView { item in
                mockdata.append(item)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
            .navigationTitle("Task")
    }
}
