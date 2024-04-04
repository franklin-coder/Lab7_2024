//
//  Lab10_2024_WatchAppApp.swift
//  Lab10_2024 WatchApp Watch App
//
//  Created by IMD 224 on 2024-04-03.
//

import SwiftUI

@main
struct Lab10_2024_WatchApp_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Treasure.self)
    }
}
