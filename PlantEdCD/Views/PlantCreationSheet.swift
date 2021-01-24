//
//  PlantCreationSheet.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/14/20.
//

import CoreData
import SwiftUI

struct PlantCreationSheet: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var plant: Plant
    
    let dismissAction: () -> Void
    
    @State private var errorAlertIsPresented = false
    @State private var errorAlertTitle = " "
    
    var body: some View {
        NavigationView{
            PlantProfile(plant: plant)
                .alert(
                    isPresented: $errorAlertIsPresented,
                    content: { Alert(title: Text(errorAlertTitle))})
                .navigationBarTitle("New Plant")
                .navigationBarItems(
                    leading: Button(
                        action: self.dismissAction,
                        label: { Text("Cancel")}),
                    trailing: Button(
                        action: self.save,
                        label: {Text("Save")}))
        }
    }
    
    private func save() {
        do {
            plant.nextWater = plant.computedNextWater
            try context.save()
            Notifier.updateNotifications(context: context)
            dismissAction()
        } catch {
            errorAlertTitle = (error as? LocalizedError)?.errorDescription ?? "An error has occurred"
            errorAlertIsPresented = true
        }
        
    
    }
}
