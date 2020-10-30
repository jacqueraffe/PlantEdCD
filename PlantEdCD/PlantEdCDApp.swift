//
//  PlantEdCDApp.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 10/30/20.
//

import SwiftUI

@main
struct PlantEdCDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
