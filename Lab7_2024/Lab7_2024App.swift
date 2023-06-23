import SwiftUI
import SwiftData

@main
struct Lab7_2024App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Treasure.self)
    }
}
