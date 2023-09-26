//
//  Wallet_WatcherApp.swift
//  Wallet Watcher
//
//  Created by Sam McIntyre on 9/25/23.
//

import SwiftUI
import SwiftData

@main
struct Wallet_WatcherApp: App {
    var sharedModelContainer: ModelContainer = {
		let schema = Schema([Expense.self, Setting.self])
		//let entities = Schema([Expense.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
	
	let loader = DefaultLoader() //loads in the defaults

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
