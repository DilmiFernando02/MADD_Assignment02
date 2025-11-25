import Foundation

struct Swipe: Codable, Identifiable {
    let id: String
    let userID: String
    let movieID: Int
    let liked: Bool
    let mood: String
    let timestamp: Date
    let dayOfWeek: Int
    let timeOfDay: String
}
