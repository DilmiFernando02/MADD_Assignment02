//
//  MoviefundayApp.swift
//  Moviefunday
//
//  Created by Malmi Perera on 2025-11-25.
//

import SwiftUI
import CoreData

@main
struct MoviefundayApp: App {
    // Core Data stack singleton used across the app
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // Root content view embedded in a window
            ContentView()
                // Inject Core Data context into the environment
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                // App-wide dark theme for cinematic feel
                .preferredColorScheme(.dark)
                // Accent color for buttons and highlights
                .tint(.red)
        }
    }
}
