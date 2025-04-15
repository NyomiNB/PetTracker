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
    //    @State private var email = ""
    @State private var fullName = ""
    // @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    @ObservedObject var emailOb = EmailValidationObj()
    @ObservedObject var passwordOb = PasswordValidationObj()
    
    
    
    //    let title: String
    //    let placeholder: String
    //    var isSecureField = false
    var body: some View {
        ZStack{
            VStack{
                Text("Create")
                    .font(.largeTitle)
                    .bold()
                Text("PetTrack")
                    .font(.largeTitle)
                Text("Account")
                    .font(.largeTitle)
                    .bold()
                
                InputView(text: $emailOb.email, title: "Email Address", placeholder:  "name@emailexample.com")
                    .padding()
                    .frame(width: 300, height: 20)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                
                Text(emailOb.error).foregroundColor(.red)
                
                InputView(text: $fullName, title: "Full Name", placeholder:  "Enter your first and last name")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                
                
                InputView(text: $passwordOb.password, title: "Password", placeholder:  "Please enter your password", isSecureField: true)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                
                InputView(text: $confirmPassword, title: "Confirm Password", placeholder:  "Please confirm your password", isSecureField: true)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                
                Text(passwordOb.error).foregroundColor(.red)
                ZStack(alignment: .trailing){
                    
                    if !passwordOb.password.isEmpty && !confirmPassword.isEmpty{
                        if passwordOb.password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color(.systemGreen))
                        } else{
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
        }
        Button{
            Task{
                try await viewModel.createUser(withEmail: emailOb.email, password: passwordOb.password, fullname: fullName)
            }
        } label:{
            
            Text("Create Account")
            
            Image(systemName: "pawprint.fill")
        }
        Button{
            Task{
                try await viewModel.resetPassword(email: emailOb.email)
            }
        } label:{
            
            Text("reset")
            
            //        .disabled(!valid)
            //        .opacity(valid ? 1.0 : 0.5)
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign In")
                        .bold()
                }
            }
            
            
        }
    }
}
class EmailValidationObj: ObservableObject {
    @Published var email = "" {
        didSet{
            if self.email.isEmpty{
                self.error = "Required"
            } else if !self.email.isValidEmail(){
                self.error = "Invalid Email"
                
            } else {
                self.error = ""
            }
        }
    }
    @Published var error = ""
}

class PasswordValidationObj: ObservableObject {
    @Published var password = "" {
        didSet{
            self.isValidPassword()
            }
        }
    
    @Published var error = ""
    
    private func isValidPassword(){
        guard !self.password.isEmpty else {
            self.error = "Required"
            return
        }
        var setPassError: Bool = !password.isValidPass()
 
        while setPassError{
            if self.password.count < 8{
                self.error = "Must be at least 8 characters"
                return
            }
//            if !self.password.containsCharacter(){
//                self.error = "Must contain at least one character"
//                return
//            }

            if !self.password.isUpperCase(){
                self.error = "Must contain at least one uppercase letter"
                return
            }
             if !self.password.containsDigit(){
                self.error = "Must contain at least one digit"
                return
            }
            print("ya")

          setPassError = false

      }
         self.error = ""

        }
          }


//        TextField("Email", text: $email)
//        TextField("Password", text: $password)
        
//
//        Button {
//             register()
//        } label:{
//            Text("Sign Up")
//        }
//        Button {
//             signin()
//        } label:{
//            Text("Sign Up")
//        }
//    }
//    func signin(){
//        Auth.auth().signIn(withEmail: email, password: password) { result, error in
//            if error != nil{
//                print(error!.localizedDescription)
//            }
//        }
//    }
//    //
//    //
//    func register(){
//        Auth.auth().createUser(withEmail: email, password: password){ result, error in
//            if error != nil{
//                print(error!.localizedDescription)
//            }
//        }
//    }


//extension LoginView: AuthenticationFormProtocol {
//    var valid: Bool{
//        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
//    }
//}
extension String{
    
    func isValidEmail() -> Bool{
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailValidation = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailValidation.evaluate(with: self)

    }
    func isValidPass() -> Bool{
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"

        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPred.evaluate(with: self)
    }
    func isUpperCase() -> Bool{
        let uppercaseRegex = ".*[A-Z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: self)

    }
    
    func isLowerCase() -> Bool{
        let lowercaseRegex = ".*[a-z]+.*"
        return NSPredicate(format: "SELF MATCHES %@", lowercaseRegex).evaluate(with: self)

    }
    
    func containsCharacter() -> Bool{
        let characterRegex = ".*[!@#$%^&*()\\-_=+{}|?>.<]+.*]"
        return NSPredicate(format: "SELF MATCHES %@", characterRegex).evaluate(with: self)

    }
    func containsDigit() -> Bool{
        let digitRegex = ".*[0-9]+.*"
        return NSPredicate(format: "SELF MATCHES %@", digitRegex).evaluate(with: self)

    }
}

//extension RegisterView: AuthenticationFormProtocol {
//    var valid: Bool{
//        return !email.isEmpty && String.isValidEmail() && !password.isEmpty && password.count > 7 && confirmPassword == password && !fullName.isEmpty
//    }
//}

 #Preview {
    RegisterView()
}
