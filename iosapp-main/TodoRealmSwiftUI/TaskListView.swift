//
//  TaskListView.swift
//  TodoRealmSwiftUI
//


import SwiftUI

struct TaskListView: View {
    @EnvironmentObject private var viewModel: TaskViewModel
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.tasks, id: \.id) { task in
                    NavigationLink (destination: TaskView(task: task)) {
                        TaskRowView(task: task)
                    }
                    Divider().padding(.leading, 20)
                }
                .animation(.default)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
