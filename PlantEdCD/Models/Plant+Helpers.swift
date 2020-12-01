
//

import Foundation
import UIKit

extension Plant {
    
    var readyToWater: Bool {
        guard let lastWatered = lastWatered else {
            return false
        }
        let twelveHoursAgo = Date().addingTimeInterval(-12*3600)
        if lastWatered < twelveHoursAgo {
            return true
        }
        return false
    }
    
    var wrappedName: String {
        get {
            name ?? ""
        }
        set(newValue) {
            objectWillChange.send()
            name = newValue
        }
    }
    
    var computedNextWater: Date? {
        if wateringFrequency > 0, let lastWatered = lastWatered {
            return Calendar.current.date(byAdding: .day, value: Int(wateringFrequency), to: lastWatered)!
        } else {
            return nil
        }
    }
    
    var typeName: String {
        get {
            type?.name ?? ""
        }
        set(newValue) {
            objectWillChange.send()
            if type == nil {
                type = Type(context: managedObjectContext!)
            }
            type!.name = newValue
        }
    }
    
    var wrappedLastWatered: Date {
        get {
            lastWatered ?? Date()
        }
        set(newValue) {
            objectWillChange.send()
            lastWatered = newValue
        }
    }
    
}

extension Date {
  var short: String {
    let formatter1 = DateFormatter()
    formatter1.dateStyle = .short
    return formatter1.string(from: self)
  }
}
