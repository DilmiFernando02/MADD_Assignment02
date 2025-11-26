//
//  ContentView.swift
//  Moviefunday
//
//  Created by Malmi Perera on 2025-11-25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // Currently selected movie for the Player tab
    @State private var selectedMovie: Movie? = nil
    // Local demo data powering Home/Search
    private let movies = sampleMovies
    // URL encoded in the QR code for suggestions
    private let suggestionURL = "https://example.com/suggest"

    var body: some View {
        // Primary navigation—four tabs
        TabView {
            NavigationStack {
                // Home grid of suggestions
                HomeView(movies: movies) { movie in
                    selectedMovie = movie
                }
            }
            .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack {
                // Filter and pick a movie
                SearchView(movies: movies) { movie in
                    selectedMovie = movie
                }
            }
            .tabItem { Label("Search", systemImage: "magnifyingglass") }

            NavigationStack {
                // Simple mock player UI
                PlayerView(movie: selectedMovie)
            }
            .tabItem { Label("Player", systemImage: "play.circle.fill") }

            NavigationStack {
                // Share suggestions via QR code
                QRView(suggestionURL: suggestionURL)
            }
            .tabItem { Label("QR", systemImage: "qrcode") }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
