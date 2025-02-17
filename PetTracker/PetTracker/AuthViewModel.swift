//
//  AuthViewModel.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseCore
 
class AuthViewModel: ObservableObject{
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
     
    init(){
        
    }
    func signIn(withEmail email: String, password: String) async throws{
        print("Sign in")
    }
    
    func createUser(withEmail email: String, password: String, fullname: String) async throws{
        print("createAccount")
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch{
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        print("sign out")

    }
    
    func deleteAccount(){
        print("delete")

    }
    
    func fetchUser() async{
        
    }
}
