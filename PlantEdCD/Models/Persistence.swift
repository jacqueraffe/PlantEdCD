//
//  Persistence.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 10/30/20.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newPlant = Plant(context: viewContext)
            newPlant.name = "Layla"
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "PlantEdCD")
        let localContainer = container
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            let context = localContainer.viewContext
            if Type.allTypes(context: context).count == 0 {
                //fill in types on first open
                if let fileURL = Bundle.main.url(forResource: "houseplants", withExtension: "json") {
                    let jsonData = try! Data(contentsOf: fileURL)
                    let data: HouseplantCategoryDictionary = try! JSONDecoder().decode(HouseplantCategoryDictionary.self, from: jsonData)
                    for (catagory, infoDictionary) in data{
                        for (typeName, info) in infoDictionary{
                            let type = Type(context: context)
                            type.name = typeName
                            type.bio = info.description
                            type.builtIn = true
                            type.catagory = catagory
                        }
                    }
                }
                try! context.save()
            }
        })
    }
}
