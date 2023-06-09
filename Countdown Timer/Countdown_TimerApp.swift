//
//  Countdown_TimerApp.swift
//  Countdown Timer
//
//  Created by Howard Benditsky on 5/18/23.
//

 
import SwiftUI

@main
struct Countdown_TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}



