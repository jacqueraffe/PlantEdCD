//
//  TypeRow.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

import SwiftUI

struct TypeRow: View {
    @ObservedObject var type: Type
    
    var body: some View {
        HStack{
            if type.photo != nil {
                Image(uiImage: type.photo! as! UIImage).resizable().scaledToFit()
            }
            VStack(alignment:.leading) {
                Text(type.wrappedName)
                Text(type.bio!)
                if let bio = type.bio {
                    Text("Last Watered: \(bio)")
                }
            }
        }
    }
}
