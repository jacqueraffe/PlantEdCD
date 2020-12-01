//
//  WateringSchedule.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 11/30/20.
//

import SwiftUI

struct WateringSchedule: View {
    //sorted by next water date, needs to be watered before today
    @FetchRequest(entity:  Plant.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Plant.nextWater, ascending: true)],
                  predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format:"wateringFrequency > 0"),
                    NSPredicate(format:"nextWater != nil"),
                    NSPredicate(format:"nextWater <= %@", Date() as NSDate)
                  ]))
    var waterNowPlants: FetchedResults<Plant>
    
    @FetchRequest(entity:  Plant.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Plant.nextWater, ascending: true)],
                  predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                    NSPredicate(format:"wateringFrequency > 0"),
                    NSPredicate(format:"nextWater != nil"),
                    NSPredicate(format:"nextWater > %@", Date() as NSDate),
                  ]))
    var waterSoonPlants: FetchedResults<Plant>
    
    var body: some View {
        List{
            if !waterNowPlants.isEmpty {
                Section(header: Text("Water Now")){
                    ForEach(waterNowPlants, id: \.self) { plant in
                        WateringScheduleRow(plant: plant)
                    }
                }
            }
            if !waterSoonPlants.isEmpty {
                Section(header: Text("Water Soon")){
                    ForEach(waterSoonPlants, id: \.self) { plant in
                        WateringScheduleRow(plant: plant)
                    }
                }
            }
        }.navigationTitle(Text("Watering Schedule"))
    }
}

struct WateringSchedule_Previews: PreviewProvider {
    static var previews: some View {
        WateringSchedule()
    }
}
