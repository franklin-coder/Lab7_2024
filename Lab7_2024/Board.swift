import SwiftUI
import SwiftData

/// Contains the collection of tiles, making up the current game board.
struct Board {
    /// The actual board.
    var tiles = [[Tile(contents: emptyTreasure)]]
    
    /// Number of columns.
    var numCols = 1
    
    /// Number of rows.
    var numRows = 1
    
    /// Total number of treasures.
    var numTreasures = 0
    
    /// Given a starting row and column, searches along the row to see if there is room available for treasure.clusterSize copies of treasure.name.
    /// If so, the treasure is placed and true is returned.  If not, false is returned.
    /// Will wrap around board edges.
    /// - Parameters:
    ///   - treasure: The treasure to place.
    ///   - randomRow: The starting row.
    ///   - randomCol: The starting column.
    /// - Returns: Whether or not the treasure could be placed.
    private func searchRow(treasure: Treasure, randomRow: Int, randomCol: Int) -> Bool {
        for i in randomRow..<randomRow + treasure.clusterSize {
            if tiles[i % numRows][randomCol].contents != emptyTreasure {
                return false
            }
        }
        
        for i in randomRow..<randomRow + treasure.clusterSize {
            tiles[i % numRows][randomCol].contents = treasure.name
        }
        
        return true
    }
    
    /// Given a starting row and column, searches along the column to see if there is room available for treasure.clusterSize copies of treasure.name.
    /// If so, the treasure is placed and true is returned.  If not, false is returned.
    /// Will wrap around board edges.
    /// - Parameters:
    ///   - treasure: The treasure to place.
    ///   - randomRow: The starting row.
    ///   - randomCol: The starting column.
    /// - Returns: Whether or not the treasure could be placed.
    private func searchColumn(treasure: Treasure, randomRow: Int, randomCol: Int) -> Bool {
        for i in randomCol..<randomCol + treasure.clusterSize {
            if tiles[randomRow][i % numCols].contents != emptyTreasure {
                return false
            }
        }
        
        for i in randomCol..<randomCol + treasure.clusterSize {
            tiles[randomRow][i % numCols].contents = treasure.name
        }
        
        return true
    }

    /// Sets up a 1 x 1 board containing a single, empty TIle
    init() {
        tiles = [[Tile(contents: emptyTreasure)]]
        numCols = 1
        numRows = 1
        numTreasures = 0
    }
    
    /// Sets up a new board with all treasures randomly placed (except that treasures of the same type are clustered together).
    /// numCols and numRows will be set to the number of treasures \* their clustersize \* ```multiplier```.
    /// numReveals is set to 0.
    /// numRemaining is set to the number of placed treasures.
    /// A new board of size numRows x numCols is created.
    /// All the treasures in treasureList are placed onto the board.
    /// - Parameters:
    ///   - treasureList: The list of treasures to be placed.
    init(treasures: [Treasure]) {
        // Figure out board dimensions
        numTreasures = treasures.reduce(0) { partialResult, currentTreasure in
            return partialResult + currentTreasure.clusterSize
        }
        numCols = numTreasures
        numRows = numCols
        
        // Initialize a board with blank tiles
        tiles = [[Tile]]()
        for i in 0..<numRows {
            var newRow = [Tile]()
            for j in 0..<numCols {
                newRow.append(Tile(contents: emptyTreasure))
            }
            tiles.append(newRow)
        }
        
        // Place all treasures
        for treasure in treasures {
            while true {
                let randomCol = Int.random(in: 0..<numCols)
                let randomRow = Int.random(in: 0..<numRows)
                
                if searchRow(treasure: treasure, randomRow: randomRow, randomCol: randomCol) {
                    break
                }
                
                if searchColumn(treasure: treasure, randomRow: randomRow, randomCol: randomCol) {
                    break
                }
            }
        }
    }
}
