//
//  InputView 2.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/15/25.
//


//
//  SwiftUIView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/15/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel

    
//    let title: String
//    let placeholder: String
//    var isSecureField = false
    
    var body: some View {
        InputView(text: $email, title: "Email Address", placeholder:  "name@emailexample.com")
        
        
        InputView(text: $fullName, title: "Full Name", placeholder:  "Please enter your first and last name")
        
        InputView(text: $password, title: "Password", placeholder:  "Please enter your password", isSecureField: true)
        
        InputView(text: $confirmPassword, title: "Password", placeholder:  "Please enter your password", isSecureField: true)

        Button{
            Task{
            try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
        }
        } label:{
        
            Text("Create Account")
            Image(systemName: "pawprint.fill")
        }
        
        Button {
            dismiss()
        } label: {
            Text("Already have an  account")
        }


        }
    
}

#Preview {
    RegisterView()
}
