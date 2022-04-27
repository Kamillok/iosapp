//
//  TodoRealmSwiftUIApp.swift
//  TodoRealmSwiftUI
//


import SwiftUI

@main
struct TodoRealmSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(TaskViewModel())
        }
    }
}
