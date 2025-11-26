import SwiftUI

struct SearchView: View {
    // User-entered search query
    @State private var query: String = ""
    let movies: [Movie]
    var onSelect: (Movie) -> Void

    // Simple case-insensitive filter on movie titles
    var filtered: [Movie] {
        guard !query.isEmpty else { return movies }
        return movies.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.white.opacity(0.7))
                // Minimal search field
                TextField("Search movies", text: $query)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(true)
                    .foregroundStyle(.white)
            }
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 12).fill(Color(red: 30/255, green: 0, blue: 0)))
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.red.opacity(0.5), lineWidth: 1))
            .padding()

            // Results list
            List {
                ForEach(filtered) { movie in
                    Button {
                        onSelect(movie)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: movie.iconName)
                                .font(.system(size: 24, weight: .semibold))
                                .foregroundStyle(.white)
                                .frame(width: 36, height: 36)
                                .background(RoundedRectangle(cornerRadius: 8).fill(movie.color.opacity(0.35)))
                            VStack(alignment: .leading, spacing: 4) {
                                Text(movie.title).foregroundStyle(.white)
                                Text(movie.subtitle).font(.caption).foregroundStyle(.white.opacity(0.6))
                            }
                            Spacer()
                            Image(systemName: "play.fill").foregroundStyle(.red)
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.plain)
                    .listRowBackground(Color.black)
                }
            }
            #if !os(tvOS)
            .scrollContentBackground(.hidden)
            #endif
            .background(Color.black)
        }
        .background(LinearGradient(colors: [Color.black, Color(red: 20/255, green: 0, blue: 0)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .navigationTitle("Search")
        #if !os(tvOS)
        .toolbarTitleDisplayMode(.large)
        #endif
    }
}
