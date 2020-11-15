//
//  PlantProfile.swift
//  PlantEdCD
//
//  Created by Jacqueline Palevich on 11/14/20.
//

import SwiftUI

struct PlantProfile: View {
    @ObservedObject var plant: Plant
    @State private var showingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        List{
            TextField("Name", text: $plant.wrappedName)
            TextField("Type", text: $plant.typeName)
                .disableAutocorrection(true)
            if let photo = plant.photo{
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
            }
            Menu("Edit Photo") {
                Button("Paste", action: camera)
                //TODO: Grey out paste if unavailable
                Button("Camera", action: camera)
                    .disabled(!UIImagePickerController.isCameraDeviceAvailable(.rear))
                Button("Gallery", action: gallery)
                Button("Clear", action: clearPhoto)
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: {}) {
                ImagePicker(image: $plant.photo, sourceType: $sourceType)
            }
        }
        .listStyle(GroupedListStyle())
    }
    
    func paste() {
        if pasteboard.hasImages{
            plant.photo = pasteboard.image
        }
    }
    
    func camera() {
        sourceType = .camera
        showingImagePicker = true
    }
    
    func gallery() {
        sourceType = .photoLibrary
        showingImagePicker = true
    }
    
    func clearPhoto() {
        plant.photo = nil
    }
    
}
