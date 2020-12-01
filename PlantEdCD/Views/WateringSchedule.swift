//
//  WateringSchedule.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 11/30/20.
//

import SwiftUI

struct WateringSchedule: View {
    @FetchRequest(entity:  Plant.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Plant.nextWater, ascending: true)],
                  predicate: NSCompoundPredicate(andPredicateWithSubpredicates: [
                   NSPredicate(format:"wateringFrequency > 0"),
                   NSPredicate(format:"nextWater != nil"),
                   NSPredicate(format:"nextWater <= %@", Date() as NSDate)
                   ]))
    var plants: FetchedResults<Plant>
    
    var body: some View {
        List{
            ForEach(plants, id: \.self) { plant in
                WateringScheduleRow(plant: plant)
            }
        }
    }
}

struct WateringSchedule_Previews: PreviewProvider {
    static var previews: some View {
        WateringSchedule()
    }
}
