import SwiftUI
import SwiftData

/// The minimum number of matching tiles.
let minClusterSize = 1

/// The maximum number of matching tiles.
let maxClusterSize = 5

/// The settings view of the app.  Updates the list of treasures.  The list of treasures is saved.
struct SettingsView: View {
    /// The list of treasures that must be placed.
    @Query var treasures : [Treasure]

    /// The context used to save the list of treasures and the board state.
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            List {
                ForEach(treasures) {
                    treasure in
                    RowView(treasure: treasure)
                }
                .onDelete {
                    if let index = $0.first {
                        modelContext.delete(treasures[index])
                    }
                }
            }
            .navigationBarTitle("Treasures")
            .toolbar {
                ToolbarItemGroup {
                    EditButton()
                    Button(
                        action: {
                            modelContext.insert(Treasure(name: emptyTreasure, clusterSize: minClusterSize))
                        },
                        label: {
                            Image(systemName: "plus")
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
