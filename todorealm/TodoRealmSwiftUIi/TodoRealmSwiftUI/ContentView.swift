//
//  ContentView.swift
//  TodoRealmSwiftUI
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                AddTaskView()
                TaskListView()
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
