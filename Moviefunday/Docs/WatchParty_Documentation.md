# WatchParty (tvOS) — Application Documentation

## Overview
WatchParty is a tvOS SwiftUI application that helps users discover movies, search quickly, and share suggestions via a QR code. It features a visual Home grid with IMDb-style ratings, a fast Search, a simple Player mock, and a QR screen to join a watch party.

- Platform: tvOS (SwiftUI)
- Language: Swift
- State: Local demo data (no network calls)
- Theme: Dark, cinematic visuals with a red accent

## App Name
- Display name: "WatchParty"
- Configured in Info.plist (`CFBundleDisplayName`, `CFBundleName`)

## Folder / File Structure
```
Moviefunday/
└── Moviefunday/
    ├── MoviefundayApp.swift        # App entry; window scene & environment
    ├── ContentView.swift           # Tab layout; hosts Home, Search, Player, QR
    ├── HomeView.swift              # Suggestions grid with poster placeholder, IMDb badge, title
    ├── SearchView.swift            # Search bar + filtered results list
    ├── PlayerView.swift            # Mock player UI, poster tile + controls
    ├── QRView.swift                # QR screen; join the watch party
    ├── Movie.swift                 # Movie model + sample data
    ├── Info.plist                  # App display name, background modes
    └── (Core Data scaffolding)     # PersistenceController, etc. (used for context)
```

## What Each File Contains
- MoviefundayApp.swift
  - Creates the app scene, injects Core Data context, forces dark mode, sets red tint.
- ContentView.swift
  - Defines TabView with 4 tabs: Home, Search, Player, QR.
  - Holds `selectedMovie` state shared with Player.
- HomeView.swift
  - 3-column square grid of movie suggestions.
  - Each tile shows: poster placeholder (2:3), large icon, IMDb badge, movie title.
  - Taps propagate selection via `onSelect`.
- SearchView.swift
  - Search field and filtered list over `sampleMovies`.
  - Case-insensitive match on title; taps call `onSelect`.
- PlayerView.swift
  - Poster-like square artwork with gradients, title/subtitle.
  - Mock progress bar and basic control buttons.
- QRView.swift
  - Displays heading, QR code placeholder, and instructions.
  - Navigation title: "Scan to join the watch party".
- Movie.swift
  - `Movie` model with `title`, `subtitle`, `iconName`, `color`, `rating`.
  - `sampleMovies` mock dataset to power UI.
- Info.plist
  - `CFBundleDisplayName` and `CFBundleName` set to "WatchParty".

## Code Map (What snippet does what)
- HomeView.swift
  - `GridItem` array: defines 3-column layout.
  - ZStack tile: gradient background + stroke; GeometryReader builds center poster (2:3) and icon.
  - IMDb badge: top-left `HStack` with "IMDb" and `movie.rating`.
  - Title: bottom-left `Text(movie.title)`.
- SearchView.swift
  - `filtered` computed property: case-insensitive title search.
  - Search bar `TextField`: binds to `query`.
  - `List` with `Button`: sends selected movie via `onSelect`.
- PlayerView.swift
  - Poster ZStack: rounded rectangle gradient + symbol icon.
  - Progress: two `Capsule` layers; width tied to `progress`.
  - Controls: `controlButton`, `playPauseButton`, and secondary actions.
- QRView.swift
  - Uses dark gradient background; navigation title set to requested copy.
- Movie.swift
  - `rating: Double` drives IMDb badges; colors tint tiles.

## Design Rationale
### Colors — Why these colors?
- Dark background improves contrast and reduces eye strain on TVs.
- Red accent provides strong visual affordance for actions and focus states.
- Per-tile `movie.color` adds variety and recognition without cluttering artwork.

### UI Element Choices
- SwiftUI `LazyVGrid` with square aspect ratio keeps a consistent, scannable grid.
- Poster placeholder (2:3) centers attention and leaves room for real artwork later.
- IMDb badge is compact (caption2) and positioned top-left for immediate visibility.
- Bottom-left title respects reading patterns and avoids overlapping the badge.
- `NavigationStack` per tab simplifies back navigation per section.

### User Experience (UX) Choices
- Clear 4-tab structure reduces cognitive load: discover, search, play, share.
- Tiles are touch-friendly on remotes; square shape reduces layout jumps.
- Minimal text on tiles avoids crowding; title + rating are the most essential facts.
- Large icons help communicate genre while placeholders stand in for posters.
- Consistent dark gradient backgrounds unify screens and focus content.

## Data Model
```
struct Movie: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let rating: Double
}
```
- `rating` is 0–10 and used for IMDb-style badges.
- `sampleMovies` provides demo content for all screens.

## Navigation
- TabView with 4 tabs; each tab wrapped in its own `NavigationStack`.
- Home and Search push through the same `onSelect` closure to set `selectedMovie`.

## Accessibility Considerations
- High-contrast colors and large icons for distance viewing.
- Limited text per tile to maximize legibility.
- Inline navigation titles on QR/Player to save vertical space on TV.

## Answers to Provided Questions
1) Why use these colours?
- Dark base ensures comfortable TV viewing and makes content pop.
- Red accent is attention-grabbing and works well on dark themes.
- Per-tile tints improve differentiation between items at a glance.

2) Explain the UI element choices
- Grid: Fast, scannable browsing with predictable alignment.
- Poster placeholder: Prepares for real artwork while keeping the layout stable.
- IMDb badge: Immediate quality signal; concise and unobtrusive.
- Title placement bottom-left: Minimizes conflict with badge and keeps hierarchy clear.
- NavigationStack per tab: Keeps section-specific back stacks clean.

3) User experience design choices
- Four clear tabs map to user goals (discover, search, play, share).
- Minimal friction: single tap to select; visible ratings for quick judgment.
- Consistent theming and spacing reduce cognitive overhead across screens.

## Setup / Run
- Open the Xcode project/workspace
- Target: tvOS
- Build and run on tvOS Simulator or Apple TV

## Future Enhancements
- Replace placeholders with real posters from a movie API.
- Persist watchlist and playback state.
- Add filtering/sorting (genre, year, rating).
- Multi-user presence for live watch parties.
