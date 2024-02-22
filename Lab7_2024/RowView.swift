import SwiftUI

/// A single settings row.
struct RowView: View {
    /// An individual treasure.
    @Bindable var treasure: Treasure
    
    var body: some View {
        HStack {
            TextField("Treasure Name", text: $treasure.name)
                .autocapitalization(.none)
                .padding()
            
            Spacer()
            
            Text("\(treasure.clusterSize)")
                .lineLimit(1)
            Stepper("Cluster Size", value: $treasure.clusterSize, in: minClusterSize...maxClusterSize, step: 1)
                .labelsHidden()
                .padding()
        }
    }
}

#Preview {
    MainActor.assumeIsolated {
        ContentView()
            .modelContainer(for: Treasure.self)
    }
}
