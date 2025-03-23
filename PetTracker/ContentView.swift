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
 
                    HomeView()
                 }
            }
        }
    }
    


#Preview {
    ContentView()
}
