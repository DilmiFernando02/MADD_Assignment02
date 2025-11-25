//
//  Movie_matchApp.swift
//  Movie_match
//
//  Created by Malmi Perera on 2025-11-22.
//

import SwiftUI
import CoreData

@main
struct Movie_matchApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var authService = AuthService()

    var body: some Scene {
        WindowGroup {
            SwiftUI.Group {
                if authService.isAuthenticated {
                    MainTabView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                } else {
                    LoginView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            }
            .environmentObject(authService)
        }
    }
}
