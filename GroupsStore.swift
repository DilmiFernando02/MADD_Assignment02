import Foundation
import Combine

@MainActor
final class GroupsStore: ObservableObject {
    @Published private(set) var groups: [MovieNightGroup] = []

    private let storageKey = "movie_night_groups_storage"

    init() {
        load()
    }

    func add(name: String, members: [String], movieDate: Date, place: String) {
        let new = MovieNightGroup(name: name, members: members, movieDate: movieDate, place: place)
        groups.append(new)
        save()
    }

    func update(group: MovieNightGroup, name: String, members: [String], movieDate: Date, place: String) {
        guard let idx = groups.firstIndex(of: group) else { return }
        groups[idx].name = name
        groups[idx].members = members
        groups[idx].movieDate = movieDate
        groups[idx].place = place
        save()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            groups.remove(at: index)
        }
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else { return }
        do {
            let decoded = try JSONDecoder().decode([MovieNightGroup].self, from: data)
            self.groups = decoded
        } catch {
            // ignore failed load
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(groups)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            // ignore failed save
        }
    }
}
