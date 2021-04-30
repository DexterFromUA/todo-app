//
//  todo_appApp.swift
//  todo-app
//
//  Created by Dexter on 30.04.2021.
//

import SwiftUI

@main
struct todo_appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
