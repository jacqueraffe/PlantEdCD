//
//  TypeProfile.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 1/8/21.
//

import SwiftUI

struct TypeProfile: View {
    @ObservedObject var type: Type
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        HStack{
            if type.photo != nil {
                Image(uiImage: type.photo! as! UIImage).resizable().scaledToFit()
            }
            VStack(alignment:.leading) {
                Text(type.wrappedName)
                if let bio = type.bio {
                    Text("\(bio)")
                }
            }
        }
    }
}
