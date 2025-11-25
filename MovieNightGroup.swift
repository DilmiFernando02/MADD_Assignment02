import Foundation

struct MovieNightGroup: Codable, Identifiable, Equatable {
    let id: String
    var name: String
    var members: [String]
    var movieDate: Date
    var place: String

    init(id: String = UUID().uuidString, name: String, members: [String], movieDate: Date, place: String) {
        self.id = id
        self.name = name
        self.members = members
        self.movieDate = movieDate
        self.place = place
    }
}
