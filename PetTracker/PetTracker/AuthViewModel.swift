//
//  AuthViewModel.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
//

import Foundation
import FirebaseAuth


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
