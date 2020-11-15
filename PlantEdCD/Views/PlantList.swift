//
//  PlantList.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/14/20.
//

import CoreData
import SwiftUI

struct PlantList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
        animation: .default)
    private var plants: FetchedResults<Plant>

    @State private var newPlantIsPresented = false
    
    var body: some View {
        List {
            ForEach(plants) { plant in
                Text("Plant named \(plant.name!)")
            }
            .onDelete(perform: deletePlants)
        }
        .toolbar {
            HStack {
                #if os(iOS)
                EditButton()
                #endif

                Button(action: addPlant) {
                    Label("Add Plant", systemImage: "plus")
                }
                .sheet (
                    isPresented: $newPlantIsPresented,
                    content: {self.newPlantCreationSheet})
            }
        }
    }
    
    private var newPlantCreationSheet: some View {
        let childContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        childContext.parent = viewContext
        return PlantCreationSheet(
            context: childContext,
            plant: Plant(context: childContext),
            dismissAction: {
                self.newPlantIsPresented = false
                do{
                    try viewContext.save()
                } catch {
                    //TODO: put in alter sysytem like in PlantCreationSheet
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            })
    }

    private func addPlant() {
        self.newPlantIsPresented = true
    }

    private func deletePlants(offsets: IndexSet) {
        withAnimation {
            offsets.map { plants[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
