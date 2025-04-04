//
//  Home.swift
//  PetTracker
//
//  Created by Nyomi Bell on 2/14/25.
//

import SwiftUI

struct NewPetView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    //    @State private var newPet = ""
    @State var name = ""
    @State var notes = ""
    init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Your Pet")){
                    TextField("Pet Name", text: $name)
                    TextField("Notes", text: $notes)
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                print("sucesss?")
                print("Pet data \(authViewModel.getData())")
                print("Pets \(authViewModel.pets)")
                  authViewModel.addPet(name: name, notes: notes)
                authViewModel.getData()
            }, label:{
                Text("Save")
            }))
            .navigationBarItems(leading: Button(action: {
                print("Cancel")
            }, label:{
                Text("Cancel")
            }))
             
        }
    }
}
#Preview {
    NewPetView()
}
