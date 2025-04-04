//
//  ContentView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
// 
 import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession == nil{
                LoginView()
            }     else {
                
                TabView{
                    HomeView()
                    Image(systemName: "house")
                    Text("Home")

//                    Text("Home").tabItem { Text("Home")
//                        Image(systemName: "house")}.tag(1)
                    
                    PetView()
                        .tabItem{
                            Image(systemName: "pawprint.fill")
                            Text("My Pets")
                        }
                    AccountView()
                        .tabItem{
                            Image(systemName: "person.crop.circle.fill")
                            Text("My Account")
                            
                        }
                    
                }
            }
        }
    }
}
    


#Preview {
    ContentView()
}
