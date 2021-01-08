//
//  TypeList.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

import CoreData
import SwiftUI

struct TypeList: View {
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Type.name, ascending: true)],
        predicate: NSPredicate(format:"builtIn == true"),
        animation: .default)
    private var types: FetchedResults<Type>
    
    var body: some View {
        List{
            ForEach(types, id: \.self) { type in
                TypeRow(type: type)
            }
        }.navigationTitle(Text("Type List"))
    }
}
