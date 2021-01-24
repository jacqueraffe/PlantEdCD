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
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Type.name, ascending: true)],
        predicate: NSPredicate(format:"builtIn == true"),
        animation: .default)
    private var types: FetchedResults<Type>
    
    var body: some View {
        
        let wateringFrequencyChoice = Binding(
            get: { Int(self.plant.wateringFrequency)},
            set: {self.plant.wateringFrequency = Int16($0)}
        )
        return List{
            TextField("Name", text: $plant.wrappedName)
            
            Picker("Type", selection: $plant.type) {
                Text("None").tag(Type?.none)
                ForEach(types, id: \.self) { type in
                    Text(type.wrappedName).tag(type as Type?)
                }
            }
            DatePicker(selection: $plant.wrappedLastWatered, in: ...Date(), displayedComponents: .date){
                Text("Select last date watered")
            }
            Picker(selection: wateringFrequencyChoice, label: Text("Watering Frequency")) {
                ForEach(0 ..< 31) {
                    Text($0 == 0 ? "None" : "\($0)")
                }
            }
             //   .pickerStyle(WheelPickerStyle())
            
            if let photo = plant.photo{
                Image(uiImage: photo)
                    .resizable()
                    .scaledToFit()
            }
            Menu("Edit Photo") {
                Button("Paste", action: paste)
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
