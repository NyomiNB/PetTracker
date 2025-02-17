//
//  PetTrackerApp.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/13/25.
//

import SwiftUI
import Firebase

@main
struct PetTrackerApp: App {
    @StateObject var viewModel = AuthViewModel()
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
