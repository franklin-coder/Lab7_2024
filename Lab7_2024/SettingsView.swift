import SwiftUI
import SwiftData

/// The minimum number of matching tiles.
let minClusterSize = 1

/// The maximum number of matching tiles.
var maxClusterSize = 5

/// The settings view of the app.  Updates the list of treasures.  The list of treasures is saved.
struct SettingsView: View {
    /// The list of treasures that must be placed.
    @Query var treasures : [Treasure]
    
    /// The context used to save the list of treasures and the board state.
    @Environment(\.modelContext) private var modelContext
    
    @State private var board = Board()
    
    
    
    
    
    var body: some View {
        NavigationStack {
            List {

                        ForEach(treasures) {

                            treasure in

                            #if os(iOS)

                                RowView(treasure: treasure, maxAllowed: maxClusterSize)

                            #else

                            RowView(treasure: treasure, maxItems: 4 - (totNum(treasures: treasures) - treasure.clusterSize))

                            #endif

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
                    
#if os(iOS)
                    EditButton()
#endif
                    
                    //                    Button(
                    //                        action: {
                    //
                    //
                    //
                    //                            modelContext.insert(Treasure(name: emptyTreasure, clusterSize: minClusterSize))
                    //
                    //                        },
                    //                        label: {
                    //                            Image(systemName: "plus")
                    //                        }
                    //                    )
                    
                    
                    
#if os(iOS)
                    
                    EditButton()
                    
                    Button(
                        
                        action: {
                            
                            modelContext.insert(Treasure(name: emptyTreasure, clusterSize: minClusterSize))
                            
                        },
                        
                        label: {
                            
                            Image(systemName: "plus")
                            
                        }
                        
                    )
                    
#else
                    
                    Button(
                        
                        action: {
                            
                            modelContext.insert(Treasure(name: emptyTreasure, clusterSize: minClusterSize))
                            
                        },
                        
                        label: {
                            
                            Image(systemName: "plus")
                            
                        }
                        
                    )
                    .disabled(totNum(treasures: treasures) >= 4)
                    
#endif
                            
        
                }
            }
        }
    }
}


func totNum (treasures: [Treasure]) -> Int {
    var sum: Int = 0
    
    for item in treasures {
        
        sum += item.clusterSize
        
    }
    
    return sum
}

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(for: Treasure.self)
    }
}
