////
////  TypeList.swift
////  PlantEd
////
////  Created by Jacqueline Palevich on 12/8/20.
////
//
//import SwiftUI
//
//struct TypeList: View {
//    
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Plant.type, ascending: true)],
//        animation: .default)
//    private var types: FetchedResults<Plant>
//    
//    var body: some View {
//        List{
//            ForEach(types, id: \.self) { plant in
//                TypeRow(type: type)
//            }
//        }.navigationTitle(Text("Type List"))
//    }
//    
//    struct TypeList_Previews: PreviewProvider {
//        static var previews: some View {
//            TypeList()
//        }
//    }
//}
