import SwiftUI

struct HomeView: View {
    @State private var selected: Movie? = nil
    let movies: [Movie]
    var onSelect: (Movie) -> Void

    // 3-column square grid for compact, visual-first layout
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(movies) { movie in
                    Button {
                        selected = movie
                        onSelect(movie)
                    } label: {
                        // Square tile with poster placeholder, rating badge, and title
                        ZStack(alignment: .topLeading) {
                            RoundedRectangle(cornerRadius: 14, style: .continuous)
                                .fill(LinearGradient(colors: [.black.opacity(0.7), movie.color.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(Color.red.opacity(0.5), lineWidth: 1)
                                )
                            // Poster placeholder area (centered 2:3 aspect)
                            GeometryReader { geo in
                                let side = min(geo.size.width, geo.size.height)
                                let posterWidth = side * 0.68
                                let posterHeight = posterWidth * 1.5
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10).fill(Color.white.opacity(0.06))
                                    )
                                    .frame(width: posterWidth, height: posterHeight)
                                    .position(x: geo.size.width/2, y: geo.size.height/2 - 6)
                                Image(systemName: movie.iconName)
                                    .font(.system(size: posterWidth * 0.4, weight: .bold))
                                    .foregroundStyle(.white.opacity(0.9))
                                    .shadow(color: .red.opacity(0.4), radius: 6, x: 0, y: 3)
                                    .position(x: geo.size.width/2, y: geo.size.height/2 - 6)
                            }

                            // IMDb rating badge
                            HStack(spacing: 4) {
                                Text("IMDb")
                                    .font(.caption2).bold()
                                Text(String(format: "%.1f", movie.rating))
                                    .font(.caption2).bold()
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 6)
                            .background(RoundedRectangle(cornerRadius: 6).fill(Color.yellow))
                            .foregroundStyle(.black)
                            .padding(8)

                            // Movie title at bottom-left
                            VStack {
                                Spacer()
                                HStack {
                                    Text(movie.title)
                                        .font(.footnote.weight(.semibold))
                                        .lineLimit(1)
                                        .foregroundStyle(.white)
                                        .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 1)
                                    Spacer()
                                }
                                .padding(.horizontal, 10)
                                .padding(.bottom, 8)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(12)
        }
        .background(LinearGradient(colors: [Color.black, Color(red: 20/255, green: 0, blue: 0)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .navigationTitle("WatchParty")
        #if !os(tvOS)
        .toolbarTitleDisplayMode(.large)
        #endif
    }
}
