import Foundation
import SwiftUI

// Domain model representing a Movie in the app
struct Movie: Identifiable, Hashable {
    let id = UUID()            // Unique identifier for lists/grids
    let title: String          // Movie title
    let subtitle: String       // Short descriptor: genre • year
    let iconName: String       // SF Symbol used as artwork placeholder
    let color: Color           // Accent color used to tint tiles
    let rating: Double         // IMDb-style rating (0–10)
}

// Local mock data used for UI prototyping and previews
let sampleMovies: [Movie] = [
    Movie(title: "Inception", subtitle: "Sci‑Fi • 2010", iconName: "film.fill", color: .red, rating: 8.8),
    Movie(title: "Interstellar", subtitle: "Sci‑Fi • 2014", iconName: "sparkles.tv.fill", color: .orange, rating: 8.6),
    Movie(title: "The Dark Knight", subtitle: "Action • 2008", iconName: "shield.fill", color: .blue, rating: 9.0),
    Movie(title: "La La Land", subtitle: "Musical • 2016", iconName: "music.note.house.fill", color: .pink, rating: 8.0),
    Movie(title: "Parasite", subtitle: "Thriller • 2019", iconName: "theatermasks.fill", color: .green, rating: 8.5),
    Movie(title: "Dune", subtitle: "Sci‑Fi • 2021", iconName: "wind", color: .teal, rating: 8.0),
    Movie(title: "Whiplash", subtitle: "Drama • 2014", iconName: "metronome.fill", color: .indigo, rating: 8.5),
    Movie(title: "Coco", subtitle: "Animation • 2017", iconName: "guitars.fill", color: .purple, rating: 8.4)
]
