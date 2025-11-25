import Foundation

struct User: Codable, Identifiable {
    let id: String
    var username: String
    var email: String
    var displayName: String
    var profileImageURL: String?
    var friendIDs: [String]
    var groupIDs: [String]
    var createdAt: Date
    var isOnline: Bool
    var deviceToken: String?

    var preferredMoods: [String: Int]
    var genrePreferences: [String: Double]
    var watchHistory: [String]
}
