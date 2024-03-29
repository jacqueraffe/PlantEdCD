//
//  TypeRow.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 12/8/20.
//

import SwiftUI

extension String {
    var cliffNotes: String{
        if let endOfFirstSentence = self.firstIndex(of: "."){
            return String(self[...endOfFirstSentence])
        } else {
            return self
        }
    }
}

struct TypeRow: View {
    @ObservedObject var type: Type
    
    var body: some View {
        HStack{
            if type.photo != nil {
                Image(uiImage: type.photo! as! UIImage).resizable().scaledToFit()
            }
            VStack(alignment:.leading) {
                Text(type.wrappedName)
                if let bio = type.bio {
                    Text("\(bio.cliffNotes)...")
                }
            }
        }
        
    }
}
