import Foundation

struct Group: Codable, Identifiable {
    let id: String
    var name: String
    var creatorID: String
    var memberIDs: [String]
    var invitedUserIDs: [String]
    var currentSessionActive: Bool
    var createdAt: Date
    var currentMood: String?
    var moviesInQueue: [Int] = []
    var matches: [GroupMatch]
}

struct GroupMatch: Codable, Identifiable {
    let id: String
    let movieID: Int
    let matchedAt: Date
    let participantIDs: [String]
    var isWatched: Bool
}
