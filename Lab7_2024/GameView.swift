//
//  MapView.swift
//  Lab7_2023
//
//  Created by Michael on 2022-05-02.
//

import SwiftUI
import SwiftData

/// The game view of the app.
/// Set up the collection of tiles every time this view appears.
/// Modifies the currently-placed collection of tiles, as treasures are correctly selected.
/// The state of the board is saved
struct GameView: View {
    /// The size of each tile
    static let tileSize = 20.0
    
    /// The game board, consisting of a collection of tiles
    @State private var board = Board()

    /// The list of treasures that must be placed.
    @Query var treasures : [Treasure]

    /// The context used to save the list of treasures and the board state.
    @Environment(\.modelContext) private var modelContext

    /// The total number of revelations so far.  This is updated every time a hidden tile is revealed.
    @State var numReveals = 0
    
    /// The number of treasures that must still be picked.
    @State var numRemaining = 0

    var body: some View {
        VStack {
            ScrollView([.horizontal, .vertical], showsIndicators: true) {
                VStack {
                    ForEach(board.tiles, id:\.first!.self) { row in
                        HStack {
                            ForEach(row) { tile in
                                Image(systemName: tile.icon)
                                    .frame(width: GameView.tileSize, height: GameView.tileSize, alignment: .center)
                                    .onTapGesture {
                                        if tile.icon != unexploredTreasure {
                                            return
                                        }
                                        
                                        tile.reveal()
                                        numReveals += 1
                                        if tile.icon != emptyTreasure {
                                            numRemaining -= 1
                                        }
                                    }
                            }
                        }
                    }
                    Spacer()
                    Text("Attempts: \(numReveals)")
                    if numRemaining > 0 {
                        Text("Total Remaining: \(numRemaining)")
                    }
                    else {
                        Text("Game Over!")
                    }
                }
                .padding()
            }
        }
        .onAppear {
            board = Board(treasures: treasures)
            numReveals = 0
            numRemaining = board.numTreasures
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(for: Treasure.self)
    }
}
