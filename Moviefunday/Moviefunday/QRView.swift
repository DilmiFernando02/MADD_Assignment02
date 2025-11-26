import SwiftUI

struct QRView: View {
    let suggestionURL: String

    var body: some View {
        GeometryReader { geo in
            let dimension = min(geo.size.width, geo.size.height)
            let qrSize = max(180, min(dimension * 0.5, 360))

            ScrollView {
                VStack(spacing: 20) {
                    Text("Scan to Suggest a Movie")
                        .font(.title2).bold()
                        .foregroundStyle(.white)

                    ZStack {
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 18/255, green: 18/255, blue: 18/255))
                            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.red.opacity(0.7), lineWidth: 1))
                            .shadow(color: .red.opacity(0.25), radius: 12, x: 0, y: 6)

                        QRGenerator.image(from: suggestionURL)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                            .frame(width: qrSize, height: qrSize)
                            .padding(24)
                    }
                    .frame(maxWidth: qrSize + 64, maxHeight: qrSize + 64)

                    VStack(spacing: 8) {
                        Text("Share this with your group. They can scan and add or suggest movies.")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.white.opacity(0.7))
                        Text(suggestionURL)
                            .font(.footnote.monospaced())
                            .foregroundStyle(.white.opacity(0.5))
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }

                    HStack(spacing: 16) {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.red, lineWidth: 1)
                            .frame(height: 44)
                            .overlay(
                                HStack(spacing: 8) {
                                    Image(systemName: "square.on.square")
                                    Text("Copy Link")
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline.weight(.semibold))
                            )
                            .onTapGesture {
                                #if os(iOS)
                                UIPasteboard.general.string = suggestionURL
                                #elseif os(macOS)
                                NSPasteboard.general.clearContents()
                                NSPasteboard.general.setString(suggestionURL, forType: .string)
                                #endif
                            }

                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.red)
                            .frame(height: 44)
                            .overlay(
                                HStack(spacing: 8) {
                                    Image(systemName: "qrcode")
                                    Text("Open Link")
                                }
                                .foregroundStyle(.white)
                                .font(.subheadline.weight(.semibold))
                            )
                            .onTapGesture {
                                // Open URL
                                guard let url = URL(string: suggestionURL) else { return }
                                #if os(iOS)
                                UIApplication.shared.open(url)
                                #elseif os(macOS)
                                NSWorkspace.shared.open(url)
                                #endif
                            }
                    }
                    .frame(maxWidth: 520)

                    Spacer(minLength: 20)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
        }
        // Dark gradient background consistent with the app theme
        .background(LinearGradient(colors: [Color.black, Color(red: 20/255, green: 0, blue: 0)], startPoint: .top, endPoint: .bottom).ignoresSafeArea())
        .navigationTitle("Scan to join the watch party")
        #if !os(tvOS)
        // Compact nav title on non-tvOS platforms
        .toolbarTitleDisplayMode(.inline)
        #endif
    }
}
