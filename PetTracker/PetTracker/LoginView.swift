//
//  LoginView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

//import SwiftUI
//import FirebaseCore
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//    return true
//  }
//}
//
//@main
//struct YourApp: App {
//  // register app delegate for Firebase setup
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//  var body: some Scene {
//    WindowGroup {
//      NavigationView {
//        ContentView()
//      }
//    }
//  }
//}
import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
     
        NavigationStack {
            Text("Login")
            
            InputView(text: $email, title: "Email Address", placeholder:
                        "name@example.com")
            
            InputView(text: $password, title: "Password", placeholder:
                        "Enter Your Password", isSecureField: true)
            Button{
                Task{
                    try await viewModel.signIn(withEmail: email, password: password)
                }
            }label:{
                Text("Sign in")
                Image(systemName: "pawprint.fill")
                
            }
            .disabled(!valid)
            .opacity(valid ? 1.0 : 0.5)
            NavigationLink(destination: RegisterView()) {
                Text("Sign Up")
            }
        }
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


extension LoginView: AuthenticationFormProtocol {
    var valid: Bool{
        return !email.isEmpty && email.contains("@") && !password.isEmpty && password.count > 5
    }
}


#Preview {
    LoginView()
}
  
 
