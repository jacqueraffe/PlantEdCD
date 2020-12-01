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
        TabView{
            plantListTab
                .tabItem{
                    Image(systemName: "leaf.fill")
                    Text("Plants")
                }
            typeListTab
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Types")
                }
            wateringScheduleTab
                .tabItem{
                    Image(systemName: "calendar.badge.clock")
                    Text("Schedule")
                }
            
        }
    }
    
    var plantListTab: some View {
        NavigationView {
            PlantList()
        }
        .onAppear{
            Notifier.requestNotificationPermissions(context: viewContext)
        }
    }
    
    var typeListTab: some View {
        Text("Types Coming Soon!")
    }
    
    var wateringScheduleTab: some View {
        Text("Calender Coming Soon!")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
