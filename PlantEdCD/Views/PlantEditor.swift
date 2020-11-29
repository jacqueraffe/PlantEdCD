//
//  PlantEditor.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/14/20.
//

import CoreData
import SwiftUI

struct PlantEditor: View {
    let context: NSManagedObjectContext
    @ObservedObject var plant: Plant
    
    var body: some View {
        PlantProfile(plant: plant)
            .onDisappear(perform: {
                do{
                    plant.nextWater = plant.computedNextWater
                    try context.save()
                    Notifier.updateNotifications(context: context)
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            })
    }
}
