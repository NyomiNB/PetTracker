//
//  ContentView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/16/25.
//
 import SwiftUI

struct ContentView: View {
     @State var selectedTab = 0
     @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession == nil{
                LoginView()
            }     else if viewModel.userSession != nil{
                
                TabView(selection: $selectedTab){
                    ReminderView()
                        .tabItem{
                            
                            Image(systemName: "house")
                            Text("Home")
                        }
                         .tag(0)
                    //                    Text("Home").tabItem { Text("Home")
                    //                        Image(systemName: "house")}.tag(1)
                    
                    PetView()
                        .tabItem{
                            Image(systemName: "pawprint.fill")
                            Text("My Pets")
                        }
                        .tag(1)
                    
                    AccountView()
                        .tabItem{
                            Image(systemName: "person.crop.circle.fill")
                            Text("My Account")
                            
                        }
                        .tag(2)
//                        .toolbarBackgroundVisibility(true, for: ToolbarPlacement...)

                    EventView()
                        .tabItem{
                            Image(systemName: "plus")
                            Text("Behaviors")
                            
                        }
                        .tag(3)
                }
                .onAppear(){
                    UITabBar.appearance().backgroundColor = .white
                }
            }
        }
    }
}
    


#Preview {
    ContentView()
}
