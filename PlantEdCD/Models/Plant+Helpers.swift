
//

import Foundation
import UIKit

extension Plant {

  var wrappedName: String {
    get {
      name ?? ""
    }
    set(newValue) {
      objectWillChange.send()
      name = newValue
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

}
