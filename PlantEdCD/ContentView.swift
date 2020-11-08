//
//  ContentView.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 10/30/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
  var body: some View {
    NavigationView {
      PlantList()
    }
  }
}

struct PlantList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.name, ascending: true)],
        animation: .default)
    private var plants: FetchedResults<Plant>

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
            }
        }
    }

    private func addPlant() {
        withAnimation {
            let newPlant = Plant(context: viewContext)
            newPlant.name = "Layla"

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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
