//
//  TypeList.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

import CoreData
import SwiftUI

struct TypeList: View {
    
    @State private var searchText = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Type.name, ascending: true)],
        predicate: NSPredicate(format:"builtIn == true"),
        animation: .default)
    private var types: FetchedResults<Type>
    
    var body: some View {
        List{
            SearchBar(text: $searchText)
            ForEach(filteredTypes, id: \.self) { type in
                NavigationLink(destination: TypeProfile(type: type)){
                    TypeRow(type: type)
                }
            }
        }.navigationTitle(Text("Type List"))
    }
    private var filteredTypes : [Type]{
        types.filter{ type in
            type.name!.contains(searchText) || searchText.isEmpty
        }
    }
}
