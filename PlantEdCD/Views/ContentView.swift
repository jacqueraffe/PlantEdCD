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
            wateringScheduleTab
                .tabItem{
                    Image(systemName: "calendar.badge.clock")
                    Text("Schedule")
                }
            typeListTab
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Types")
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
    
    var wateringScheduleTab: some View {
        NavigationView {
            WateringSchedule()
        }
    }
    
    var typeListTab: some View {
        NavigationView {
            TypeList()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
