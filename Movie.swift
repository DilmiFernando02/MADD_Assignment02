import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double
    let genres: [Genre]
    let runtime: Int?
    var availableOn: [StreamingProvider]

    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
}

struct Genre: Codable, Identifiable { let id: Int; let name: String }

struct StreamingProvider: Codable { let name: String; let logoPath: String }
