import SwiftData

/// An individual tile on the map.
@Observable class Tile: Identifiable {
    /// Tile contents; default is empty.
    var contents = emptyTreasure
    
    /// Whether the tile has been revealed or not; default is false.
    var revealed = false
    
    /// The tile contents if the tile has been explored, else ```unexploredTreasure```.
    var icon : String {
        get {
            revealed ? contents : unexploredTreasure
        }
    }
    
    /// Creates a Tile with the given contents.  The Tile will initially not be revealed.
    /// - Parameter contents: The name of the treasure; must match a string found in SF Symbols; no error checking is done on this parameter.
    init(contents: String) {
        self.contents = contents
        self.revealed = false
    }
    
    /// Reveals the Tile.
    func reveal() {
        self.revealed = true
    }
}

extension Tile: Hashable {
        static func == (lhs: Tile, rhs: Tile) -> Bool {
            lhs.id == rhs.id
        }
    
        func hash(into hasher: inout Hasher) {
            hasher.combine(contents)
            hasher.combine(revealed)
        }
}
