//
//  User.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
//

import Foundation
struct User: Identifiable, Codable{
    let id: String
    let fullName: String
    let email: String
    
}
extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "John Doe", email: "Ilovepuppies@gmail.com")
}
