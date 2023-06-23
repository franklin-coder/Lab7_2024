import SwiftData

/// An empty treasure.
let emptyTreasure = "circle"

/// An unexplored treasure.
let unexploredTreasure = "questionmark"

/// An individual treasure.
@Model class Treasure : Identifiable {
    /// The name of the treasure.
    var name = emptyTreasure
    
    /// The number of treasures that are clustered together.
    var clusterSize = 0
    
    /// Creates a treasure with the given parameters.
    /// - Parameters:
    ///   - name: The name of the treasure; must match a string found in SF Symbols; no error checking is done on this parameter.
    ///   - groupSize: The number of treasures that are clustered together; no error checking is done on this parameter.
    init(name: String, clusterSize: Int) {
        self.name = name
        self.clusterSize = clusterSize
    }
}
