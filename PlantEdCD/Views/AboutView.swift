//
//  AboutView.swift
//  PlantEd
//
//  Created by Jacqueline Palevich on 9/6/21.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    var body: some View {
        if isWide {
            HStack{
                Image("granny").resizable().scaledToFit()
                aboutText.frame(maxWidth: 300)
            }
        } else {
            VStack{
                Image("granny").resizable().scaledToFit()
                aboutText.frame(maxWidth: 300)
            }
        }
    }
    
    
    @ViewBuilder
    var aboutText: some View {
        VStack{
            Text("""
    I wrote this app for my Independent Studies class. I hope it helps you all to \
    remember to water your plants! :)

    Plant information provided by wikipedia.org/wiki/Houseplant under the \
    Creative Commons Attribution-ShareAlike License.\
    My github:
    https://github.com/jacqueraffe/PlantEdCD
    """)
            HStack{
                Link("Source Code", destination: URL(string:"https://github.com/jacqueraffe/PlantEdCD" )!).padding()
                Link("Wikipedia", destination: URL(string:"https://en.wikipedia.org/wiki/Houseplant" )!)            }.padding()
        }
        
    }
    
    var isWide: Bool {
        if let horizontalSizeClass = horizontalSizeClass {
            return horizontalSizeClass == .regular
        } else {
            return false
        }
    }
}

