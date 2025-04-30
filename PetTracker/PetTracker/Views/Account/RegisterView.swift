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
    
    var measurements: CGFloat = 130
    
    
    //    let title: String
    //    let placeholder: String
    //    var isSecureField = false
    var body: some View {
        ZStack{
            Image("catPicture").opacity(0.9)
                .frame(width: 2000, height:2000, alignment: .top)
                     Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
           Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 150)
            Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle
            
            VStack{
                HStack{
                    Text("Create")
                        .font(.title)
                        .bold()
                    Text("PetTrack")
                        .font(.title)
                    Text("Account")
                        .font(.title)
                        .bold()
                }
                TextField("", text: $emailOb.email, prompt: Text ("Email Address"))
                //  InputView(text: $emailOb.email, title: "", placeholder:  "Email Address")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.white.opacity(1.0))
                    .foregroundColor(.black)

                    .cornerRadius(20.0)
                
                Text(emailOb.error).foregroundColor(.red)
                  TextField("", text: $fullName, prompt: Text("First and Last Name"))
                //                InputView(text: $fullName, title: "Full Name", placeholder:  "Enter your first and last name")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)
                
                 SecureField("", text: $passwordOb.password, prompt: Text ("Password"))
 
                //                InputView(text: $passwordOb.password, title: "Password", placeholder:  "Please enter your password", isSecureField: true)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)
                
                 SecureField("", text: $confirmPassword, prompt: Text ("Confirm Password"))
 .padding()
                    .frame(width: 300, height: 50)
                
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)
                
                Text(passwordOb.error).foregroundColor(.red)
                ZStack(alignment: .trailing){
                    
                    if !passwordOb.password.isEmpty && !confirmPassword.isEmpty{
                        if passwordOb.password == confirmPassword {
                            HStack{
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(Color(.systemGreen))
                                Text("Passwords match")
                            }
                        } else{
                            HStack{
                                
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(Color(.systemRed))
                                Text("Passwords must match")
                            }
                        }
                    }
                }
                 Button{
                    Task{
                        try await viewModel.createUser(withEmail: emailOb.email, password: passwordOb.password, fullname: fullName)
                    }
 
                } label:{
                    HStack{
                        Text("Create Account")
                        
                        Image(systemName: "pawprint.fill")
                    }
                    .frame(width: 200, height: 50)
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)

                    
                }
                
                Button {
                    dismiss()
                } label: {
                    HStack{
                        Text("Already have an account?")
                        Text("Sign In")
                     }
                    .padding()
                    .padding()
                    .frame(width: 500, height: 50)
                    .background(.white.opacity(0.2))
                    .cornerRadius(20.0)

                }
            }
        }
        
    }
}

class EmailValidationObj: ObservableObject {
    @Published var email = "" {
        didSet{
            if self.email.isEmpty{
                self.error = "Email Required"
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
            self.error = "Password Required"
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
