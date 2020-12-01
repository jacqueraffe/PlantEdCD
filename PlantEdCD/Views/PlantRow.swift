//
//  PlantRow.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/29/20.
//

import SwiftUI

struct PlantRow: View {
    @ObservedObject var plant: Plant
    
    var body: some View {
        HStack{
            if plant.photo != nil {
                Image(uiImage: plant.photo!).resizable().scaledToFit()
            }
            VStack(alignment:.leading) {
                Text(plant.wrappedName)
                Text(plant.typeName)
                if let lastWatered = plant.lastWatered {
                    Text("Last Watered: \(lastWatered.short)")
                }
                let wateringFrequency = plant.wateringFrequency
                if wateringFrequency != 0 {
                    Text("Watering Frequency: \(wateringFrequency)")
                }
                if let nextWater = plant.nextWater {
                    Text("Next Water: \(nextWater.short)")
                }
            }
        }
    }
}
