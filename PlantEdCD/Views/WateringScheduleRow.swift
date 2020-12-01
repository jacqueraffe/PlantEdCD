//
//  WaterScheduleRow.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 11/30/20.
//

import SwiftUI

struct WateringScheduleRow: View {
    @ObservedObject var plant: Plant
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack{
            if plant.photo != nil {
                Image(uiImage: plant.photo!).resizable().scaledToFit()
            }
            VStack(alignment:.leading) {
                Text(plant.wrappedName)
                if let nextWater = plant.nextWater {
                    Text("Next Water: \(nextWater.short)")
                }
                if plant.readyToWater {
                    Button(action: {
                        plant.lastWatered = Date()
                        plant.nextWater = plant.computedNextWater
                        try! viewContext.save()
                    }){
                        Text("Watered")
                    } .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
