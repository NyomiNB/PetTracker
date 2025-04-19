//
//  Pet.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//

import Foundation
import SwiftUI
// Pet(id: "d", name: "String", notes: "note")

 
struct Pet: Identifiable{
    
var id: String
let name: String
let age: Int
let weight: Double
let notes: String
let image: String   
  }
let pets = [Pet]()
