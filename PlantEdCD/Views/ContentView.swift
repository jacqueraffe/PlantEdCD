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
            aboutTab
                .tabItem{
                    Image(systemName: "gear")
                    Text("About")
                }
        }
    }
    
    var plantListTab: some View {
        NavigationView {
            PlantList()
            Text("Swipe right to see the plant list.")
        }
        .onAppear{
            Notifier.requestNotificationPermissions(context: viewContext)
        }
    }
    
    var wateringScheduleTab: some View {
        NavigationView {
            WateringSchedule()
            Text("Swipe right to see the watering schedule.")
        }
    }
    
    var typeListTab: some View {
        NavigationView {
            TypeList()
            Text("Swipe right to see the type list.")
        }
    }
    
    var aboutTab: some View {
        aboutText.frame(maxWidth: 300)
    }
    
    @ViewBuilder
    var aboutText: some View {
        Text("""
I wrote this app for my Independent Studies class. I hope it helps you all to \
remember to water your plants! :)

Plant information provided by wikipedia.org/wiki/Houseplant under the \
Creative Commons Attribution-ShareAlike License.
""")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
