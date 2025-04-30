//MOST UPDATED SENIOR PROJECT

//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//
import SwiftUI
import Firebase

struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
    @ObservedObject var emailObj = EmailObject()
    @ObservedObject var passwordObj = PasswordObject()

//    @ObservedObject var email = EmailValidationObj()
//    @ObservedObject var password = PasswordValidationObj()

    @EnvironmentObject var viewModel: AuthViewModel
    var measurements: CGFloat = 130
    var body: some View {
          NavigationStack {
 
                 ZStack{
                     Image("catPicture").opacity(0.9)
 // x- 0 left
//y- 0 up
                VStack{
                    Text("Welcome")
                        .font(.largeTitle)
                        .bold()
                    
                    Text("To PetTracker")
                        .font(.largeTitle)
                    
                    Text("Enter your email and password")
                        .font(.caption)
                        .opacity(1.00)
                        .padding(.bottom)
                    
//                    Text("Email Address")
//                        .bold()
//                        .font(.title3)
                     TextField("", text: $emailObj.usedEmail, prompt: Text("Email Address"))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)
                    
//                    Text("Password")
//                        .bold()
//                        .font(.title3)
                   
                     SecureField("", text: $passwordObj.usedPassword, prompt: Text("Password"))
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.white.opacity(1.0))
                    .cornerRadius(20.0)

                                    Button{
                        Task{
                            try await viewModel.signIn(withEmail: emailObj.usedEmail, password: passwordObj.usedPassword)
                        }
                    } label: {
                        HStack{
                            Text("Sign in")
                            Image(systemName: "pawprint.fill")
 
                        }
                        .padding()
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(.white.opacity(1.0))
                        .cornerRadius(20.0)

                    }
                    //            .disabled(!valid)
                    //            .opacity(valid ? 1.0 : 0.5)
                    NavigationLink(destination: RegisterView()) {
                        HStack{
                            Text("Don't have an account? Sign Up")
                            Image(systemName: "pawprint")
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
}
 //extension RegisterView: AuthenticationFormProtocol {
//    var valid: Bool{
//        return
//        !email.isEmpty && email.contains("@") && !password.isEmpty && password.count
class EmailObject: ObservableObject {
    @Published var usedEmail = "" {
        didSet{
            if self.usedEmail.isEmpty{
                self.loginError = "Required"
            } else if !self.usedEmail.isValidEmail(){
                self.loginError = "Invalid Email"
                
            } else {
                self.loginError = ""
            }
        }
    }
    @Published var loginError = ""
}
class PasswordObject: ObservableObject {
    @Published var usedPassword = ""
    
    @Published var error = ""
    
    private func isValidPassword(){
        guard !self.usedPassword.isEmpty else {
            self.error = "Required"
            return
        }
    }
}


#Preview {
    LoginView()
}
  
 
