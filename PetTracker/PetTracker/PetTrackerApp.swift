//
//  PetTrackerApp.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/13/25.
//

import SwiftUI

@main
struct PetTrackerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
