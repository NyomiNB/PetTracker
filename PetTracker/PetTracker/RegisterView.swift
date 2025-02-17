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

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        Text(title)
            .foregroundColor(Color(.darkGray))
        
        if isSecureField{
            SecureField(placeholder, text: $text)
        } else{
            TextField(placeholder, text: $text)

        }
//        TextField("Email", text: $email)
//        TextField("Password", text: $password)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
