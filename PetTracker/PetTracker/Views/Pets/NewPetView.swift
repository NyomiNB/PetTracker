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
    @State var age = 0
    @State var weight = 0.0
//    @State var image = ""

    init(){
        authViewModel.getData()
    }
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Your Pet")){
                    //TODO: Stepper for age or calendar
                    //TODO: Allow user to input pet weight
                    TextField("Pet Name", text: $name)
                    TextField("Notes", text: $notes)
//                    TextField("Image", text: $image)
 
                }
                
            }
            .navigationBarItems(trailing: Button(action: {
                print("sucesss?")
                print("Pet data \(authViewModel.getData())")
                print("Pets \(authViewModel.pets)")
                authViewModel.addPet(name: name, age: age, weight: weight, notes: notes)
                    //TODO: Add editable image variable to addpetMethod
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
