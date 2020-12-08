//
//  Type+Helpers.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

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
    
}
