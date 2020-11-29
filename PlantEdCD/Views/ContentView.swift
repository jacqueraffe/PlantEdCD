//
//  ContentView.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 10/30/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  var body: some View {
    NavigationView {
      PlantList()
    }
    .onAppear{
        Notifier.requestNotificationPermissions(context: viewContext)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
