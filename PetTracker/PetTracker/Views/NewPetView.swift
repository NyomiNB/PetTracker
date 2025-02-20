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
        VStack{
            TextField("New Pet", text: $name)
            TextField("Notes", text: $notes)

            Button{
                //add pet
                authViewModel.addPet(name: name, notes: notes)
  //clear fields
                
                name=""
                notes=""
 
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
}

#Preview {
    NewPetView()
}
