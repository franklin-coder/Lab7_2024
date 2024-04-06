import SwiftUI

var sum: Int = 0
/// A single settings row.
struct RowView: View {
    /// An individual treasure.
    @Bindable var treasure: Treasure
    @State private var board = Board()
    
    var maxItems: Int
    
    var body: some View {
        HStack {
            TextField("Treasure Name", text: $treasure.name)
                //.autocapitalization(.none)
                .padding()
            
            Spacer()
            
            Text("\(treasure.clusterSize)")
                .lineLimit(1)
            
#if os(watchOS)
            Stepper("Cluster Size", value: Binding(
                get: { self.treasure.clusterSize },
                set: { newValue in
                    // Esta condición verifica si el total de tesoros es mayor a 4.
                    // Si es así, establece el tamaño del cluster en 4; de lo contrario, usa el valor nuevo.
                    self.treasure.clusterSize = self.board.numTreasures > 4 ? min(newValue, 4) : newValue
                }
            ), in: minClusterSize...maxItems, step: 1) // Asegúrate de que el rango también tiene un máximo de 4
            .labelsHidden()
            .padding()
#else
            Stepper("Cluster Size", value: $treasure.clusterSize, in: minClusterSize...maxClusterSize, step: 1) // Asegúrate de que el rango también tiene un máximo de 4
            .labelsHidden()
            .padding()
#endif
            
        }
        
        
        
      
        
    }
    
   
}


func totNum (treasure: [Treasure]) -> Int {
   
    
    for item in treasure {
        
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
