//
//  TaskViewModel.swift
//  TodoRealmSwiftUI
//

import Foundation
import Combine
import RealmSwift

final class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private var token: NotificationToken?
    
    init() {
        setupObserver()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            let results = realm.objects(TaskObject.self)
            
            token = results.observe({ [weak self] changes in
                self?.tasks = results.map(Task.init)
                    .sorted(by: { $0.completedAt > $1.completedAt })
                    .sorted(by: { !$0.completed && $1.completed })
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func addTask(title: String) {
        let taskObject = TaskObject(value: [
            "title": title,
            "completed": false
        ])
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(taskObject)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func markComplete(id: String, completed: Bool) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            let task = realm.object(ofType: TaskObject.self, forPrimaryKey: objectId)
            try realm.write {
                task?.completed = completed
                task?.completedAt = Date()
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func remove(id: String) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            if let task = realm.object(ofType: TaskObject.self, forPrimaryKey: objectId) {
                try realm.write {
                    realm.delete(task)
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func update(id: String, newTitle: String, dueDate: Date?) {
        do {
            let realm = try Realm()
            let objectId = try ObjectId(string: id)
            let task = realm.object(ofType: TaskObject.self, forPrimaryKey: objectId)
            try realm.write {
                task?.title = newTitle
                task?.dueDate = dueDate
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
