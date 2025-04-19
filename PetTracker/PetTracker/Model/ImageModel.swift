//
//  ImageModel.swift
//  PetTracker
//
//  Created by Nyomi Bell on 4/17/25.
//
import SwiftUI

struct ImageModel: Identifiable{
    var id: String = UUID().uuidString
    var image: String
}
let images: [ImageModel] = [
    .init(id: "cat", image: "catPlaceholder"), .init(id: "dog", image: "dogPlaceholder"), .init(id: "fish", image: "fishPlaceholder")


    
]
