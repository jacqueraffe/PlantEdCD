//
//  Notifier.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/29/20.
//

import CoreData
import UserNotifications

struct Notifier {
  static func requestNotificationPermissions(context: NSManagedObjectContext) -> Void {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
      if success {
        updateNotifications(context: context)
      } else if let error = error {
        print(error.localizedDescription)
      }
    }
  }

  static func updateNotifications(context: NSManagedObjectContext) {
    // Cancel existing notifications

    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.removeAllPendingNotificationRequests()

    // Fetch books with a non-zero reading period.

    let fetchRequest = NSFetchRequest<Plant>(entityName: "Plant")
    fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Plant.nextWater, ascending: true)]
    fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
      NSPredicate(format:"wateringFrequency > 0"),
      NSPredicate(format:"nextWater != nil"),
      NSPredicate(format:"nextWater > %@", Date() as NSDate)
      ])
    fetchRequest.fetchLimit = 64

    do {
      let plants = try context.fetch(fetchRequest)

      // Group by nextWater date.

      for (nextWater, plants) in Dictionary(grouping: plants, by: { $0.nextWater! }) {
        let plantNames = plants.compactMap(\.name).joined(separator:", ")
        let content = UNMutableNotificationContent()
        content.title = "Water plants"
        content.subtitle = plantNames
        content.sound = UNNotificationSound.default

        let triggerDate = Calendar.current.dateComponents([.year,.month,.day], from: nextWater)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content, trigger: trigger)
        // TODO: add a "Mark Read" action to the notification.
        notificationCenter.add(request) {error in
          if let error = error {
            print("error: \(error)")
          }
        }
      }
    } catch {
      print("Fetch failed")
    }
  }

}
