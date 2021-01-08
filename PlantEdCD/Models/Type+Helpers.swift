//
//  Type+Helpers.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

import CoreData
import Foundation
import UIKit

extension Type {
    
    var wrappedName: String {
        get {
            name ?? ""
        }
        set(newValue) {
            objectWillChange.send()
            name = newValue
        }
    }
    
    static func allTypes(context: NSManagedObjectContext) -> [Type] {
        let typesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Type")
        
        do{
            let fetchedTypes = try context.fetch(typesFetch) as! [Type]
            return fetchedTypes
        } catch {
            fatalError("Faied to fetch types: \(error)")
        }
    }
    
}
