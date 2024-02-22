import SwiftUI

/// The different tab views of the app.
enum TabSelection: Int {
    case Game
    case Settings
}

/// The main view of the app.
/// Updates the current tabSelection, based on user interaction.
struct ContentView: View {
    /// The currently-selected tab view.
    @State private var tabSelection: TabSelection = .Game
    
    var body: some View {
        VStack {
            TabView(selection: $tabSelection) {
                GameView()
                    .tabItem {
                        Text("Game")
                    }
                    .tag(TabSelection.Game)
                
                SettingsView()
                    .tabItem {
                        Text("Settings")
                    }
                    .tag(TabSelection.Settings)
            }
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(for: Treasure.self)
    }
}
