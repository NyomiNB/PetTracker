//
//  PetView.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/19/25.
//

import SwiftUI

struct PetView: View {
 
    @ObservedObject var authViewModel = AuthViewModel()
    @State private var showPopup = false
    init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            List(authViewModel.pets){item in
                Text(item.name)
            }
            .navigationTitle("My Pets")
            .navigationBarItems(trailing: Button(action: {
                showPopup.toggle()
                print("add pet")
            }, label:{
                Image(systemName: "plus")
                
            }))
            
            .sheet(isPresented: $showPopup){
                NewPetView()
             }
        }
    }
}

#Preview {
    PetView()
}
