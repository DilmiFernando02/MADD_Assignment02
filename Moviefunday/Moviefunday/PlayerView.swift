import SwiftUI
import AVKit

struct PlayerView: View {
    let movie: Movie?                    // Movie to play, if any
    @State private var isPlaying: Bool = false
    @State private var progress: Double = 0.25 // Mock playback progress

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let artworkSize = min(width * 0.7, 360)

            ScrollView {
                VStack(spacing: 20) {
                    if let movie {
                        // Poster-like square artwork
                        ZStack {
                            RoundedRectangle(cornerRadius: 24, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [movie.color.opacity(0.28), Color.black.opacity(0.6)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color.red.opacity(0.7), lineWidth: 1)
                                )
                                .frame(width: artworkSize, height: artworkSize)
                            Image(systemName: movie.iconName)
                                .font(.system(size: artworkSize * 0.32, weight: .bold))
                                .foregroundStyle(.white)
                                .shadow(color: .red.opacity(0.5), radius: 12)
                        }

                        VStack(spacing: 6) {
                            Text(movie.title)
                                .font(.title).bold().foregroundStyle(.white)
                            Text(movie.subtitle)
                                .font(.subheadline).foregroundStyle(.white.opacity(0.7))
                        }
                        .padding(.top, 4)

                        // Progress bar (mocked)
                        VStack(spacing: 8) {
                            ZStack(alignment: .leading) {
                                Capsule().fill(Color.white.opacity(0.15)).frame(height: 6)
                                Capsule().fill(Color.red).frame(width: max(8, (width - 32) * progress), height: 6)
                            }
                            HStack {
                                Text("0:45").font(.caption2).foregroundStyle(.white.opacity(0.7))
                                Spacer()
                                Text("2:50").font(.caption2).foregroundStyle(.white.opacity(0.7))
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal)

                        // Primary controls (dummy actions)
                        HStack(spacing: 28) {
                            controlButton(system: "backward.fill") { /* prev */ }
                            playPauseButton
                            controlButton(system: "forward.fill") { /* next */ }
                        }

                        // Secondary actions
                        HStack(spacing: 16) {
                            secondaryButton(title: "Add to Queue", system: "text.badge.plus") { }
                            secondaryButton(title: "Share", system: "square.and.arrow.up") { }
                        }
                    } else {
                        // Empty state when no movie is selected
                        Spacer(minLength: 80)
                        VStack(spacing: 8) {
                            Image(systemName: "film.stack")
                                .font(.system(size: 56))
                                .foregroundStyle(.white.opacity(0.8))
                            Text("Select a movie to start")
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        Spacer(minLength: 80)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
                .padding(.horizontal, 16)
            }
        }
        .background(LinearGradient(colors: [Color.black, Color(red: 20/255, green: 0, blue: 0)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .navigationTitle("Player")
        #if !os(tvOS)
        .toolbarTitleDisplayMode(.inline)
        #endif
    }
    // MARK: - Controls
    private func controlButton(system: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            ZStack {
                Circle().fill(Color.white.opacity(0.08)).frame(width: 56, height: 56)
                Image(systemName: system)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
    }

    private var playPauseButton: some View {
        Button { isPlaying.toggle() } label: {
            ZStack {
                Circle().fill(Color.red).frame(width: 72, height: 72)
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(.plain)
        .shadow(color: .red.opacity(0.5), radius: 10, x: 0, y: 6)
    }

    private func secondaryButton(title: String, system: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: system)
                Text(title)
            }
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(RoundedRectangle(cornerRadius: 14).stroke(Color.red, lineWidth: 1))
            .foregroundStyle(.white)
        }
        .buttonStyle(.plain)
    }
}
