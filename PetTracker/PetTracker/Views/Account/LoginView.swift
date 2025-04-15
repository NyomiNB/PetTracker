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
                Circle().fill(.blue.opacity(0.1))
                Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 60, y: 140)
                Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 340, y: 140)
                Circle().fill(.blue.opacity(0.1)).frame(width: measurements, height: measurements).position(x: 210, y: 100)//middle
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
                        .opacity(0.8)
                        .padding(.bottom)
                    
                    InputView(text: $emailObj.usedEmail, title: "Email Address", placeholder:
                                "name@example.com")
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                    
                    InputView(text: $passwordObj.usedPassword, title: "Password", placeholder:
                                "Enter Your Password", isSecureField: true)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .cornerRadius(20.0)
                    
                    Button{
                        
                        Task{
                            try await viewModel.signIn(withEmail: emailObj.usedEmail, password: passwordObj.usedPassword)
                        }
                    } label: {
                        Text("Sign in")
                        Image(systemName: "pawprint.fill")
                        
                    }
                    //            .disabled(!valid)
                    //            .opacity(valid ? 1.0 : 0.5)
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up")
                        Image(systemName: "pawprint")

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
  
 
