import Foundation

enum Mood: String, CaseIterable, Codable {
    case tired = "Tired & Chill"
    case adventurous = "Adventurous"
    case needLaughs = "Need Laughs"
    case thinkingMood = "Thinking Mood"
    case romantic = "Romantic"
    case scared = "Want Thrills"
    case nostalgic = "Nostalgic"
    case anythingGoes = "Anything Goes"

    var icon: String {
        switch self {
        case .tired: return "bed.double.fill"
        case .adventurous: return "figure.hiking"
        case .needLaughs: return "face.smiling"
        case .thinkingMood: return "brain.head.profile"
        case .romantic: return "heart.fill"
        case .scared: return "bolt.fill"
        case .nostalgic: return "clock.arrow.circlepath"
        case .anythingGoes: return "shuffle"
        }
    }

    var genreMapping: [Int] {
        switch self {
        case .tired: return [18, 10749, 10751]
        case .adventurous: return [12, 878, 14]
        case .needLaughs: return [35]
        case .thinkingMood: return [18, 9648, 53]
        case .romantic: return [10749]
        case .scared: return [27, 53]
        case .nostalgic: return [16, 10751, 10402]
        case .anythingGoes: return []
        }
    }
}
